import processing.serial.*;

float dato=0.0, dato1=0.0, dato2=0.0;
String valor="";
ArrayList<Float>g1= new ArrayList<Float>();
ArrayList<Float>g2= new ArrayList<Float>();
int max =100;//maximo 100datos y cuando se llene se eliminen.
Serial puerto;
void setup(){
  size(600,300);//tamaño de la ventana
  puerto=new Serial(this,"COM5",115200);//Habilitar el puerto
  //sincronizar los datos
  puerto.bufferUntil('\n');//esperar un salto de linea para empezar a recibir valores.
}

void draw(){
  background(255);//color
  stroke(0);
  fill(100);
  textSize(24);
  text("Dato original"+dato,10,20);
  
  /*stroke(0);
  fill(100);
  textSize(24);
  text("Dato map 1y 50"+dato1,10,50);*/
  stroke(0);
  fill(255,0,0);
  textSize(24);
  text("Dato map  50 y 100"+dato2,10,80);
  stroke(0,0,0);
  noFill();
  beginShape();
  for(int i= 0; i<g1.size(); i++){
    vertex(i * (width / float(max)),g1.get(i));
  }
  endShape();
  
}
void serialEvent(Serial puerto){
  valor = puerto.readStringUntil('\n');
  if(valor!=null){
    dato= float(valor);//convertir el float de dato para poder hacer las operaciones.
    dato1= map(dato,1,500,1,50);
    dato2=map(dato,1,500,50,100);
  g1.add(dato1);
  g2.add(dato2);
  
  if(g1.size() > max){
    g1.remove(0);
  }
  if(g2.size() > max){
    g2.remove(0);
  }

  }
}
