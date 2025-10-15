#include<WiFi.h>
const char* ssdi= "informatica7";
const char* password="Info_@@7";
WiFiServer serve(12345);
WiFiClient cliente;
void setup() {
  Serial.begin(115200);
  WiFi.begin(ssdi,password);
  while(WiFi.status() != WL_CONNECTED){

    delay(1000);
    Serial.println("Conectandose....");
  }
  Serial.println("Cliente concetado");
  Serial.println(WiFi.localIP());
  serve.begin();
}
void loop() {
  int r= random(0,255);
  int g= random(0,255);
  int b= random(0,255);
  //String colores = String(r)+"-"+String(g)+"-"+String(b);
  //WiFiClient cliente = serve.available();
  if(!cliente || !cliente.connected()){
    cliente= serve.available();
  }
      cliente.println(r);
      Serial.println(r);
      delay(500);
}
