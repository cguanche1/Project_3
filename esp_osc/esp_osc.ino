#include <WiFi.h>
#include <WebServer.h>
#include <WiFiUdp.h>
//#include <OSCMessage.h>


/* Put your SSID & Password */
const char* ssid = "CarJo";  // Enter SSID here
const char* password = "squidland";  //Enter Password here

/* Put IP Address details */
IPAddress local_ip(192,168,1,1);
IPAddress gateway(192,168,1,1);
IPAddress subnet(255,255,255,0);

WebServer server(80);

WiFiUDP udp;

void setup() {
  Serial.begin(115200);

  WiFi.softAP(ssid, password);
  WiFi.softAPConfig(local_ip, gateway, subnet);


  pinMode(32,INPUT);
    server.begin();
}

void loop(){

    float x = analogRead(32);
    
    udp.beginPacket("192.168.1.2",57222);
    udp.print(String(x));
    udp.endPacket();
  
  //Wait for 1 second
  delay(1000);
  
}
