#include<ArduinoJson.h>
#define po 32
void setup() {
  Serial.begin(115200);
  

}
void loop() {
  StaticJsonDocument<100> doc;

  int valor = map(analogRead(po),100,1000,10,100);
  
  doc["Labels"] = "Sensor";
  doc["values"] = valor;

  serializeJson(doc,Serial);
  Serial.println();
  delay(1000);
}
