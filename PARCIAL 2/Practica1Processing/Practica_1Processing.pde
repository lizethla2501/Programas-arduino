import processing.serial.*; // Importa la librería para manejar comunicación serial

Serial puerto; // Crea un objeto para manejar el puerto serial
String dato=""; // Variable donde se guardará la lectura completa del puerto
String t="",h="",tf=""; // Variables para guardar temperatura, humedad y temperatura en Fahrenheit
int tope=15; // Límite máximo de puntos que se graficarán
ArrayList<Float> temperatura = new ArrayList<Float>(); // Lista para guardar los valores de temperatura
ArrayList<Float> humedad = new ArrayList<Float>(); // Lista para guardar los valores de humedad
ArrayList<Float> tF2 = new ArrayList<Float>(); // Lista para guardar los valores de temperatura en Fahrenheit

void setup(){
 size(400,200); // Define el tamaño de la ventana del programa (ancho=400, alto=200)
 //print(Serial.list()); // Si se descomenta, muestra todos los puertos seriales disponibles en la consola
 
 puerto= new Serial(this, "COM7",115200); // Abre el puerto serial COM7 a una velocidad de 115200 baudios (debe coincidir con el del ESP32)
 puerto.bufferUntil('\n'); // Espera hasta recibir un salto de línea para procesar los datos completos
}

void draw(){
  background(255,255,255); // Limpia la pantalla en cada iteración y la pinta de blanco
  
  // ====== TABLA DE DATOS (lado izquierdo de la ventana) ======
  for(int x=1; x<humedad.size();x++){ // Recorre los datos guardados
    fill(0); // Color negro para el texto
    textSize(14); // Tamaño de letra
    text("Humedad: ",50,15); // Título de la columna de humedad (posición X=50, Y=15)
    text(humedad.get(x),50,x*35); // Muestra el valor de humedad (posición vertical depende de x)
    text("Temperatura °C: ",150,15); // Título de columna temperatura °C
    text(temperatura.get(x),150,x*35); // Valor de temperatura
    text("Temperatura °F: ",270,15); // Título columna temperatura °F
    text(tF2.get(x),270,x*35); // Valor temperatura en °F
  }

  // ====== GRÁFICA DE TEMPERATURA ======
  stroke(0,255,0); // Color verde para los ejes
  line(410,550,780,550); // Eje X (va desde X=410 hasta X=780, y=550)
  line(410,100,410,552); // Eje Y (va desde Y=100 hasta Y=552 en X=410)
  
  // IMPORTANTE SOBRE COORDENADAS:
  // En Processing, el punto (0,0) está en la esquina superior izquierda.
  // Aumentar Y hacia abajo y aumentar X hacia la derecha.
  // Por eso, para "subir" un valor (por ejemplo, mayor temperatura), se resta al valor Y.
  // map() convierte un rango de valores a otro. Ejemplo: map(t, 0,50, 550,100)
  // convierte la temperatura entre 0°C y 50°C a una posición vertical entre 550 (abajo) y 100 (arriba).

  if(temperatura.size() > 1){ // Solo graficar si hay más de un dato
    stroke(255,0,0); // Color rojo para la línea de la gráfica
    noFill(); // No rellenar la forma
    beginShape(); // Inicia la forma que conectará los puntos de temperatura
    
    for(int i=0; i< temperatura.size();i++){ // Recorre los valores de temperatura
      fill(0); // Texto negro
      textSize(14); // Tamaño del texto
      text("Temperatura: ",430,225); // Etiqueta lateral
      text(temperatura.get(i),430,240); // Muestra el último valor recibido

      float t= temperatura.get(i); // Guarda el valor de temperatura actual
      // map(valor, rango_inicial_min, rango_inicial_max, rango_final_min, rango_final_max)
      float y= map(t, 0,50, 550,100); // Convierte la temperatura en coordenada Y (más temperatura = más arriba)
      float x= map(i, 0,tope, 430,770); // Espacia los puntos en el eje X entre 430 y 770
      vertex(x,y); // Dibuja un punto de la gráfica en la posición (x,y)
    }
    endShape(); // Cierra la forma y une todos los puntos (genera la línea de la gráfica)
  }
}

void serialEvent(Serial puerto){ // Este método se ejecuta automáticamente cuando llegan datos por el puerto serial
  dato= puerto.readStringUntil('\n'); // Lee la línea completa que llega (hasta '\n')
  if(dato !=null){ // Si la lectura no está vacía
    dato = trim(dato); // Elimina espacios o saltos de línea extra
    print(dato); // Muestra el dato recibido en la consola de Processing
    String []val = dato.split("-"); // Divide la cadena por los guiones, ejemplo: "60-25-77" → ["60","25","77"]
    h = val[0]; // Primer valor: humedad
    t= val[1]; // Segundo valor: temperatura °C
    tf = val[2]; // Tercer valor: temperatura °F
    humedad.add(float(h)); // Agrega la humedad a la lista
    temperatura.add(float(t)); // Agrega la temperatura °C
    tF2.add(float(tf)); // Agrega la temperatura °F

    if(humedad.size() > tope){ // Si ya hay más de 15 datos, elimina el primero (para mantener el gráfico en movimiento)
      humedad.remove(0);
      temperatura.remove(0);
      tF2.remove(0);
    }
  }
}
