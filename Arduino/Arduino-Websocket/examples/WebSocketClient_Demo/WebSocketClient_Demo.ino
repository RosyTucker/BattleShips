#include <SPI.h>
#include <Ethernet.h>

// Here we define a maximum framelength to 64 bytes. Default is 256.
#define MAX_FRAME_LENGTH 64

// Define how many callback functions you have. Default is 1.
#define CALLBACK_FUNCTIONS 1

#include <WebSocketClient.h>

EthernetClient client;
WebSocketClient webSocketClient;

void setup() {
  
  Serial.begin(9600);  
    if (Ethernet.begin(mac) == 1) {
        Serial.print("Configured Ethernet with IP: ");
        Serial.println(Ethernet.localIP());
        connectClient();
        delay(1000);
    }else{
        Serial.println("Could not configure Ethernet");
        while(1) {
          // Hang on failure
        }  
    }

  // Handshake with the server
  webSocketClient.path = "/";
  webSocketClient.host = "10.93.20.76:9456";
  
  if (webSocketClient.handshake(client)) {
    Serial.println("Handshake successful");
  } else {
    Serial.println("Handshake failed.");
    while(1) {
      // Hang on failure
    }  
  }
}

void loop() {
  String data;
  
  if (client.connected()) {
    
    data = webSocketClient.getData();

    if (data.length() > 0) {
      Serial.print("Received data: ");
      Serial.println(data);
    }
    
    // capture the value of analog 1, send it along
    pinMode(1, INPUT);
    data = String(analogRead(1));
    
    webSocketClient.sendData(data);
    
  } else {
    
    Serial.println("Client disconnected.");
    while (1) {
      // Hang on disconnect.
    }
  }
  
  // wait to fully let the client disconnect
  delay(3000);
}
