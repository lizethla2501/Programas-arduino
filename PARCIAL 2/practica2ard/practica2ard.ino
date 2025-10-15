
//#include "BluetoothSerial.h"
//#include <DHT.h>
#define pin 34
//#define DHTTYPE DHT11
//BluetoothSerial conexion;
//DHT dht(pin,DHTTYPE);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  
  //conexion.begin("ESPLIZ");
  //dht.begin();
}

void loop() {
  delay(500);  // Espera entre lecturas (mínimo 2 segundos para DHT11)
  
  int h = analogRead(pin);
  float valor = map(h,1,1000,1,100);  // Escala el valor a un rango de 1 a 100 (por ejemplo, en %)
  Serial.println(valor);
 
  delay(500);
}