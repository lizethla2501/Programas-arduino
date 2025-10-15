#include<WiFi.h>
const char* ssid= "informatica7";
const char* password="Info_@@7";
WiFiServer serve(12345);
WiFiClient cliente;
#define btn 2
#define buzz 4
bool bandera = false;
void setup() {
  pinMode(btn,INPUT);
   pinMode(buzz,OUTPUT);
   Serial.begin(115200);
   WiFi.begin(ssid,password);
  while(WiFi.status() != WL_CONNECTED){
    delay(1000);
    Serial.println("Conectandose....");
  }
  Serial.println("Cliente concetado");
  Serial.println(WiFi.localIP());
  serve.begin();
}
void loop() {
  int estado = digitalRead(btn);
  Serial.print(estado);
  delay(100);
  if(estado ==1 || bandera == true){
    Serial.println("Boton presionado");
    if(estado == 1){
      Serial.println("Cambio de bandera");
      bandera= !bandera;
      Serial.print("Bandera: ");
      Serial.println(bandera);
      delay(500);
    }
    if(bandera == true){
        tone(buzz,100);
        Serial.println("Sonido");
        delay(1000);
        noTone(buzz);
        int g= random(0,255);
        if(!cliente || !cliente.connected()){
          cliente = serve.available();
        }
        cliente.println(g);
  }else{
    noTone(buzz);
    Serial.println("Sin Sonido");
  }
  }
}
