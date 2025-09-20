import processing.serial.*;

Serial puerto;
float dato=0.0, dato1=0.0;
ArrayList<Float>g1= new ArrayList<Float>();
//ArrayList<Float>g2= new ArrayList<Float>();
int max =100;//maximo 100datos y cuando se llene se eliminen.
String valor="";
void setup(){
  size(600,300);//tamaño de la ventana
  puerto=new Serial(this,"COM5",115200);//Habilitar el puerto
  //sincronizar los datos
  puerto.bufferUntil('\n');//esperar un salto de linea para empezar a recibir valores.
}

void draw(){
  background(255);//color
  stroke(0);
  fill(0,255,0);
  textSize(24);
  text("Dato original"+dato1,10,20);
  
  
  
  stroke(255,0,0);
  float yMin=map(100,10,100,height-10,100);
  line(0,yMin,width,yMin);
  stroke(0,0,0);
  noFill(); 
  beginShape();
  for(int i= 0; i<g1.size(); i++){
    float y=g1.get(i);
    vertex(i * (width / float(max)),y);
  }
  endShape();
  
}
void serialEvent(Serial puerto){
  valor = puerto.readStringUntil('\n');
  if(valor!=null){
    dato= float(valor);//convertir el float de dato para poder hacer las operaciones.
    dato1= map(dato,1,4095,height-10,100);
    //dato2=map(dato,1,500,50,100);
    print(dato1+'\n');
  g1.add(dato1);
  
  //g2.add(dato2);
  
  if(g1.size() > max){
    g1.remove(0);
  }
  //if(g2.size() > max){
    //g2.remove(0);
  //}

  }
}
