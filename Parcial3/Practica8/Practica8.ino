#include <ArduinoJson.h>
#define po 34 

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);


}

void loop() {
  // put your main code here, to run repeatedly:
  StaticJsonDocument<100> doc;
  int valor = map(analogRead(po) ,100,1000,10,100);
  
  doc["Labeles"] = "Sensor";
  doc["values"] = valor;
 
  serializeJson(doc,Serial);
  Serial.println();
  delay(1000);




}
