#include<WiFi.h>
const char* ssid= "informatica7";
const char* password="Info_@@7";
WiFiServer serve(12345);
WiFiClient cliente;

#define LED_R 16
#define LED_G 17
#define buzz 19
#define btn 4
bool bandera = false;
int contador =0;
bool estadoAnterior = HIGH;


void setup() {
  pinMode(btn,INPUT_PULLUP);
  pinMode(LED_R, OUTPUT);
  pinMode(LED_G, OUTPUT);
  pinMode(buzz,OUTPUT);
   Serial.begin(115200);
   WiFi.begin(ssid,password);//poner esto cuando es wifi
  while(WiFi.status() != WL_CONNECTED){
    delay(1000);
    Serial.println("Conectandose....");
  }
  Serial.println("Cliente conectado");
  Serial.println(WiFi.localIP());//para que de la IP
  digitalWrite(LED_R,HIGH);
  digitalWrite(LED_G,LOW);

}

void loop() {
  if(!cliente || cliente.connected()){
    cliente = serve.available();
  }

  int estadoActual = digitalRead(btn);

  if (estadoAnterior == HIGH && estadoActual == LOW) {
    delay(50); // antirrebote

    if (!bandera) {
      // Primera pulsación: cambiar a verde
      bandera = true;
      digitalWrite(LED_R, LOW);
      digitalWrite(LED_G, HIGH);
      contador = 0;
      Serial.println("Modo verde activado");
    } 
    else {
      // Ya está en verde: contar pulsos
      contador++;
      Serial.print("Contador: ");
      Serial.println(contador);

      tone(buzz, 1000);
      delay(300);
      noTone(buzz);

      // Enviar contador a Processing si hay cliente
      if (cliente && cliente.connected()) {
        cliente.println(contador);
        Serial.println("Dato enviado a Processing: " + String(contador));
      }

      // Si llega a 5, reiniciar
      if (contador >= 5) {
        bandera = false;
        contador = 0;
        digitalWrite(LED_R, HIGH);
        digitalWrite(LED_G, LOW);
        Serial.println("Ciclo completo, regreso a rojo");
      }
    }
  }

  estadoAnterior = estadoActual;

 
  
}