#include <SPI.h>
#include <Ethernet.h>
//Server
EthernetClient client;
byte serverIP[] = { 10, 93, 20, 76 };
String server = "10.93.20.76";
int serverPort = 9456;
int buttonPin = 12;
int setupLedPin = 8;
int moveLedPin = 2;
bool isSetup = false;

//Your Arduino
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xBC, 0xAA };

void setup() {
  randomSeed(analogRead(0));
  configureSerial();
  configureEthernet();
  pinMode(buttonPin, INPUT);
  pinMode(setupLedPin, OUTPUT);
  pinMode(moveLedPin, OUTPUT);
}

void loop() {  
  if(digitalRead(buttonPin) == HIGH){
      digitalWrite(setupLedPin, HIGH);
      delay(200);
      isSetup = true;
      Serial.println("ButtonPressed");
      String boatsJson = "{\"boats\":[{\"s\":\"0,0\",\"e\":\"0,4\"},{\"s\":\"2,4\",\"e\":\"2,5\"},{\"s\":\"9,0\",\"e\":\"9,2\"},{\"s\":\"6,7\",\"e\":\"6,9\"},{\"s\":\"5,6\",\"e\":\"8,6\"}]}";
      postJSON("/setup", boatsJson);
      digitalWrite(setupLedPin, LOW);
  }else if(isSetup == true){
       digitalWrite(moveLedPin, HIGH);
       int xValue = random(0,10);
       int yValue = random(0,10);
       String moveJson = createMove(xValue, yValue); 
       postJSON("/makeMove", moveJson);
       digitalWrite(moveLedPin, LOW);
       delay(200);
   }
}

String createMove(int xValue, int yValue) {
  String moveStringOne = "{\"move\":{\"x\":";
  String moveStringTwo = ",\"y\":";
  String moveStringThree =  "}}";
  String fullMoveString = moveStringOne + xValue + moveStringTwo + yValue +moveStringThree;
  return fullMoveString;
}

void postJSON(String route, String jsonData) {
    if (connectClient()) {
       client.println("POST " + route + " HTTP/1.1");
       client.println(createRequestMetaData(serverPort, jsonData));
       client.println();
       client.println();
       client.println(jsonData);
       client.stop();
    }
}


String createRequestMetaData(int serverPort, String data){
    return  "Host: " + server + ":" + String(serverPort) + "\r\nConnection: close\r\nAccept: */*\r\nContent-Type: application/json\r\nContent-Length: " + String(data.length());
}

void configureSerial() {
    Serial.begin(9600);
    while (!Serial) {
      ;
    }
}

void configureEthernet() {
    if (Ethernet.begin(mac) == 1) {
        Serial.print("Configured Ethernet with IP: ");
        Serial.println(Ethernet.localIP());
        connectClient();
        delay(1000);
    }else{
        Serial.println("Could not configure Ethernet");
    }
}

bool connectClient() {
   client.connect(serverIP, serverPort);
   return client.connected();
}
