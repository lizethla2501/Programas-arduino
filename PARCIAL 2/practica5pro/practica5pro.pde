import processing.net.*;
Client cliente;
ArrayList<Float> gra = new ArrayList<Float>();
String valor = "0", dato = "";

void setup() {
  size(800, 400);
  try {
    // Cambia esta IP por la que imprime tu ESP32
    cliente = new Client(this, "192.168.16.202", 12345);
    println("Conectado al ESP32");
  } catch (Exception e) {
    println("Error en la conexión: " + e);
  }
}
void draw() {
  background(255);
  fill(0);
  textSize(40);
  textAlign(CENTER);
  text("Valor recibido: " + valor, width/2, height/2);
  if (cliente != null && cliente.active() && cliente.available() > 0) {
    String mens = cliente.readStringUntil('\n');
    if (mens != null) {
      dato = mens.trim();
      valor = dato;
      gra.add(float(dato));
      println("Dato recibido: " + dato);
      if (gra.size() > 20) {
        gra.remove(0);
      }
    }
  } else if (cliente != null && !cliente.active()) {
    println("Cliente desconectado, intentando reconectar...");
    cliente = new Client(this, "192.168.16.202", 12345);
  }
}
