#include <ArduinoJson.h>


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

}

void loop() {
  // put your main code here, to run repeatedly:
  StaticJsonDocument<200> doc;//creacion del docuemnto json

  JsonArray labels= doc.createNestedArray("labels");//creamos la etiqueta queva ser parte del documento para agregar elementos.
  labels.add("A");
  labels.add("B");
  labels.add("C");

  JsonArray values= doc.createNestedArray("values");//creamos la etiqueta queva ser parte del documento para agregar elementos.
  values.add(random(20,100));
  values.add(random(20,100));
  values.add(random(20,100));
  serializeJson(doc,Serial);
  Serial.println();

  delay(1000);
}
