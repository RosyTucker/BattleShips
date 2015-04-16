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
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xBC, 0xAA };

void setup() {
  pinMode(transmitPin, OUTPUT);
  pinMode(errorPin, OUTPUT);
  setupSerial();
  setupEthernet();
  setupWebSocket();
}

void loop() {
  if (client.connected()) {
    digitalWrite(errorPin, LOW);
    digitalWrite(transmitPin, HIGH);
    sendMove();
    digitalWrite(transmitPin, LOW);
  } else {
    Serial.println("Client disconnected.");
    digitalWrite(errorPin, HIGH);
  }
  delay(2000);
}

void recieveMove() {
  String data;
  webSocketClient.getData(data);
  if (data.length() > 0) {
    Serial.println(data);
  }
}
void sendMove() { 
    int xValue = random(0,10);
    int yValue = random(0,10);
    String moveJson = createMove(xValue, yValue); 
    Serial.println("Sending:");
    Serial.println(moveJson);
    webSocketClient.sendData(moveJson);
}

String createMove(int xValue, int yValue) {
  String moveStringOne = "{\"move\":{\"x\":";
  String moveStringTwo = ",\"y\":";
  String moveStringThree =  "}}";
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
