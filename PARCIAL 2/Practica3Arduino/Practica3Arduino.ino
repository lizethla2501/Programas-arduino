
#define pin 15
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  
  //conexion.begin("ESPLIZ");
  //dht.begin();
}

void loop() {
  delay(3000);  // Espera entre lecturas (mínimo 2 segundos para DHT11)
   int h= analogRead(pin);
   float valor= map(h,1,1000,1,100);
   Serial.println(valor);
   delay(500);
}