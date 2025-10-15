
import processing.serial.*; // 1. Importar la librería para comunicación serial

Serial puerto; // Objeto para manejar el puerto
float alturaBarra = 0; // Variable para guardar el valor del potenciómetro

void setup() {
  size(800, 400); // Tamaño de la ventana
  
  // Muestra los puertos disponibles en la consola. ¡Descomenta si no sabes cuál es tu puerto!
  // printArray(Serial.list()); 
  
  // 2. Conectar al puerto serie. CAMBIA "COM7" por el puerto de tu Arduino.
  // La velocidad (115200) debe ser la misma que en el código de Arduino.
  String nombrePuerto = Serial.list()[0]; // Intenta conectar al primer puerto disponible
  puerto = new Serial(this, nombrePuerto, 115200);
  
  // 3. Le decimos a Processing que lea hasta recibir un "salto de línea" (\n)
  puerto.bufferUntil('\n'); 
}

void draw() {
  background(255); // Fondo blanco, se limpia en cada fotograma
  
  int anchoBarra = 150;
  int base = 350; // Posición del eje X (línea del suelo)
  int xPos = width/2 - anchoBarra/2; // Centrar la barra en la ventana

  // Dibuja los ejes de referencia
  stroke(200); // Color gris para los ejes
  line(50, base, width - 50, base); // Eje horizontal
  line(50, base, 50, 50);          // Eje vertical

  // === DIBUJO DE LA BARRA ACTUALIZADA ===
  
  // Cambia el color si el valor es alto (por ejemplo, más del 80%)
  if (alturaBarra > 80) {
    fill(255, 100, 100); // Rojo
    stroke(255,0,0);
  } else {
    fill(100, 100, 255); // Azul
    stroke(0,0,255);
  }
  
  // Dibuja el rectángulo (la barra)
  // Su altura depende del último valor recibido del Arduino
  rect(xPos, base - alturaBarra, anchoBarra, alturaBarra);

  // Muestra el valor numérico encima de la barra
  fill(0); // Texto negro
  textSize(32);
  textAlign(CENTER);
  // nf() formatea el número para que se vea mejor (ej. "75.3")
  text(nf(alturaBarra, 0, 1), width/2, base - alturaBarra - 15); 
}


// 4. Esta función se ejecuta AUTOMÁTICAMENTE cuando llegan datos de Arduino
void serialEvent(Serial miPuerto) {
  // Lee la cadena de texto que llega (ej. "75.3")
  String dato = miPuerto.readStringUntil('\n');
  
  // Si el dato no es nulo, lo procesamos
  if (dato != null) {
    // Limpia espacios en blanco y convierte el texto a un número
    alturaBarra = float(trim(dato));
    println("Valor recibido: " + alturaBarra); // Imprime en la consola para depurar
  }
}
