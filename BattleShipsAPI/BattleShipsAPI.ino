#include <SPI.h>
#include <Ethernet.h>
#include <WebSocketClient.h>

//Server
byte server[] = { 10,93,20,76 };
int port = 2999;
char hostString[] = "10.93.20.76:2999";
EthernetClient client;
WebSocketClient webSocketClient;

//Arduino
int transmitPin = 2;
int errorPin = 8;
int buttonPin = 9;
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xBC, 0xAA };

// Game
bool registered = false;

void setup() {
  pinMode(transmitPin, OUTPUT);
  pinMode(errorPin, OUTPUT);
  pinMode(buttonPin, INPUT);
  setupSerial();
  setupEthernet();
  setupWebSocket();
}

void loop() {
  if (client.connected()) {
    digitalWrite(errorPin, LOW);
    if(digitalRead(buttonPin) == HIGH) {
      registered = false;
      return;
    }
    if(!registered) {
      Serial.println("Printing");
      digitalWrite(transmitPin, HIGH);
      registerAsPlayer();
      digitalWrite(transmitPin, LOW);
    } else {
      digitalWrite(transmitPin, HIGH);
      sendMove();
      digitalWrite(transmitPin, LOW);
      recieveMove();
    }
  } else {
    Serial.println("Client disconnected.");
    digitalWrite(errorPin, HIGH);
    setup();
  }
}

void registerAsPlayer() {
  String registration = "{\"type\":\"register\",\"data\":{\"boats\":[{\"s\":\"2,3\",\"e\":\"4,5\"},{\"s\":\"8,8\",\"e\":\"8,9\"}]}}";
  webSocketClient.sendData(registration);
  delay(2000);
  registered = true;
}

void recieveMove() {
  String data;
  while (data.length() <= 0) {
      webSocketClient.getData(data);
  }
  Serial.println(data);
}
void sendMove() { 
    int xValue = random(0,10);
    int yValue = random(0,10);
    String moveJson = createMove(xValue, yValue); 
    Serial.println("Sending:");
    Serial.println(moveJson);
    webSocketClient.sendData(moveJson);
    delay(2000);
}

String createMove(int xValue, int yValue) {
  String moveStringOne = "{\"type\":\"move\",\"data\":{\"move\":{\"x\":";
  String moveStringTwo = ",\"y\":";
  String moveStringThree =  "}}}";
  String fullMoveString = moveStringOne + xValue + moveStringTwo + yValue +moveStringThree;
  return fullMoveString;
}

/******************************************/
/*             Setup Helpers              */
/******************************************/ 

void setupSerial() {
    Serial.begin(9600);
    while (!Serial) {
       digitalWrite(errorPin, HIGH);
    } 
}

void setupEthernet() {
  if (Ethernet.begin(mac) == 1) {
        Serial.print("Configured Ethernet with IP: ");
        Serial.println(Ethernet.localIP());
        client.connect(server, port);
        delay(1000);
    }else{
        Serial.println("Could not configure Ethernet");
        while(1) {
           digitalWrite(errorPin, HIGH);
        }  
    }
}

void setupWebSocket() {
  webSocketClient.path = "/";
  webSocketClient.host = hostString;
  if (webSocketClient.handshake(client)) {
    Serial.println("Handshake successful");
  } else {
    Serial.println("Handshake failed");
    while(1) {
      digitalWrite(errorPin, HIGH);
    }  
  }
}
