#include <SPI.h>
#include <Ethernet.h>

//Server
EthernetClient client;
byte serverIP[] = { 10, 93, 20, 76 };
int serverPort = 9456;

//Your Arduino
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xBC, 0xAA };

void setup() {
  randomSeed(analogRead(0));
  configureSerial();
  configureEthernet();
  postJSON("/setup", "{\"grid\": \"0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\"}");
}

void loop() {    
  int xValue = random(0,12);
  int yValue = random(0,12);
  String moveJson = createMove(xValue, yValue);
  postJSON("/makeMove", moveJson);
  delay(1000);
}

String createMove(int xValue, int yValue) {
  String moveStringOne = "{\"move\":{\"x\":";
  String moveStringTwo = ",\"y\":";
  String moveStringThree =  "}}";
  String fullMoveString = moveStringOne + xValue + moveStringTwo + yValue +moveStringThree;
  return fullMoveString;
}

void postJSON(String route, String jsonData) {
    connectClient();
    Serial.println("Posting: ");
    Serial.print(jsonData);
    if (client.connected()) {
      String newLine = "\n";
      String requestLine1 = "POST " + route + " HTTP/1.1";
      String requestLine2 = "Host: 10.93.20.76:" + serverPort;
      String requestLine3 = "Accept: */*";
      String requestLine4 = "Content-Type: application/json";
      String requestLine5 = "Content-Length: " + jsonData.length();
      client.println(requestLine1 + newLine + requestLine2 + newLine + requestLine3 + newLine + requestLine4 + newLine + requestLine5 + newLine + newLine + jsonData);
      Serial.println(" -- Posted");
    }
    client.stop();
}

void configureSerial() {
    Serial.begin(9600);
    while (!Serial) {
      ; // wait for serial port to connect. Needed for Leonardo only
    }
    Serial.println("Serial ready");
}

void configureEthernet() {
    Serial.println("Configuring ethernet");
    if (Ethernet.begin(mac) == 1) {
        Serial.print("Configured Ethernet with IP: ");
        Serial.println(Ethernet.localIP());
        connectClient();
        delay(1000); //wait to initialise
    }else{
        Serial.println("Could not configure Ethernet");
    }
}

void connectClient() {
   client.connect(serverIP, serverPort);
}
