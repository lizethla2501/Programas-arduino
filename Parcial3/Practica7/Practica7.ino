#include <ArduinoJson.h>


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);


}

void loop() {
  // put your main code here, to run repeatedly:
  StaticJsonDocument<100> doc;
  
  doc["Labeles"] = "Sensor";
  doc["values"] = random(10,200);
 
  serializeJson(doc,Serial);
  Serial.println();
  delay(1000);




}
