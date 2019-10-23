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

  pinMode(34,INPUT); //Bottom Force Sensors
  pinMode(35,INPUT); //Top Force Sensors
  pinMode(32,INPUT); //Black Photoelectric
  pinMode(33,INPUT); //Red Photoelectric
  pinMode(25,INPUT); //Blue Photoelectric
  pinMode(26,INPUT); //Green Photoelectric
  pinMode(27,INPUT); //Piezoelectric
    server.begin();
}

void loop(){

    Serial.print("Reading Values");
    float FB = analogRead(34);
    float FT = analogRead(35);
    float PBa = analogRead(32);
    float PR = analogRead(33);
    float PBu = analogRead(25);
    float PG = analogRead(26);
    float Pe = touchRead(27);
    
    udp.beginPacket("192.168.1.2",57222);
    udp.print(String(FB) + " " + String(FT) + " " + String(PBa) + " " + String(PR) + " " + 
    String(PBu) + " " + String(PG) + " " + String(Pe));
    udp.endPacket();

    Serial.print("Sent packet");
  //Wait for .1 seconds
  delay(100);
  
}
