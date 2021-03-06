#include <ArduinoJson.h>
#include <SPI.h>
#include <Ethernet.h>
#include <WebSocketClient.h>

//Server - CHANGE THESE
byte server[] = { 192,168, 0, 2 };
int port = 2999;
char hostString[] = "192.168.0.2:2999";

EthernetClient client;
WebSocketClient webSocketClient;

//Arduino
int transmitPin = 2;  // Connect an LED to this pin
int errorPin = 8;    // Connect an LED to this pin 
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xBC, 0xDA }; //CHANGE THIS

// Game
bool registered = false;

void setup() {
  pinMode(transmitPin, OUTPUT);
  pinMode(errorPin, OUTPUT);
  setupSerial();
  setupEthernet();
  setupWebSocket();
}

void loop() {
  digitalWrite(errorPin, LOW);
  if (client.connected()) {
    if(!registered) {
      Serial.println("Printing");
      digitalWrite(transmitPin, HIGH);
      registerAsPlayer();
      digitalWrite(transmitPin, LOW);
      if(!getIsFirstFromStartMessage(recieveData())){
        String otherPlayersMove = recieveData();
      }
    } else {
      digitalWrite(transmitPin, HIGH);
      sendMove();
      String result = recieveData();
      digitalWrite(transmitPin, LOW);
      String otherPlayersMove = recieveData();
    }
  } else {
    Serial.println("Client disconnected.");
    digitalWrite(errorPin, HIGH);
    setup();
  }
}

void registerAsPlayer() {
  String registration = "{\"type\":\"register\",\"data\":{\"boats\":[{\"start\":\"2,3\", \"length\": 3, \"direction\": \"S\"}, {\"start\":\"5,6\", \"length\": 5, \"direction\": \"N\"}]}}";
  webSocketClient.sendData(registration);
  delay(1000);
  registered = true;
}


/******************************************/
/*             Game Helpers              */
/******************************************/

String recieveData() {
  String data;
  while (data.length() <= 0) {
      webSocketClient.getData(data);
  }
  Serial.println(data);
  return data;
}
void sendMove() { 
  int xValue = random(0,10);
  int yValue = random(0,10);
  String moveJson = createMove(xValue, yValue); 
  Serial.println("Sending:");
  Serial.println(moveJson);
  webSocketClient.sendData(moveJson);
  delay(1000);
}

String createMove(int xValue, int yValue) {
  String moveStringOne = "{\"type\":\"move\",\"data\":{\"x\":";
  String moveStringTwo = ",\"y\":";
  String moveStringThree =  "}}";
  String fullMoveString = moveStringOne + xValue + moveStringTwo + yValue +moveStringThree;
  return fullMoveString;
}

char* stringToCharArray(String string) {
  char charBuf[100];
  string.toCharArray(charBuf, 100);
}

bool getIsFirstFromStartMessage(String startMessageJson) {
  StaticJsonBuffer<200> jsonBuffer;
  JsonObject &root = jsonBuffer.parseObject(stringToCharArray(startMessageJson));
  bool isFirst = root["data"]["isFirst"];
  Serial.println(isFirst);
  return isFirst;
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
