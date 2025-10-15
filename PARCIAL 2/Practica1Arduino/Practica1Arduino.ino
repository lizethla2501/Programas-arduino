#include "BluetoothSerial.h"

#include <DHT.h>
#define pin 32
BluetoothSerial conexion;
#define DHTTYPE DHT11
DHT dht(pin,DHTTYPE);
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  conexion.begin("ESPLIZ");
  dht.begin();
}

void loop() {
  delay(2000);  // Espera entre lecturas (mínimo 2 segundos para DHT11)
  
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  float tf = dht.readTemperature(true);
  
  
  Serial.print("Humedad: ");
  Serial.print(h);
  Serial.println(" %");
  
  Serial.print("Temperatura en °C: ");
  Serial.print(t);
  Serial.println(" °C");
  
  Serial.print("Temperatura en °F: ");
  Serial.print(tf);
  Serial.println(" °F");

  conexion.println("hola mundo");
  delay(500);
}