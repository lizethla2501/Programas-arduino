#include<WiFi.h>
const char* ssid= "informatica7";
const char* password="Info_@@7";
WiFiServer serve(12345);
WiFiClient cliente;

void setup() {
   Serial.begin(115200);
   WiFi.begin(ssid,password);//poner esto cuando es wifi
  while(WiFi.status() != WL_CONNECTED){
    delay(1000);
    Serial.println("Conectandose....");
  }
  Serial.println("Cliente conectado");
  Serial.println(WiFi.localIP());//para que de la IP
  serve.begin();//hasta aqui
}
void loop() {
  int g= random(0,255);
  if(!cliente || !cliente.connected()){
    cliente = serve.available();
  }
  cliente.println(g);
  delay(1000);
}

