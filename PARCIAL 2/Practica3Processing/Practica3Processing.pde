import processing.serial.*;
String dato="";
ArrayList<Float> datos= new ArrayList<Float>();
Serial puerto;

void setup(){
 size(800,600);
 puerto= new Serial(this, "COM5",115200);
}

void draw(){
  background(255);
  stroke(255,0,0);
  line(50,300, width -20,300);
  line(45, 30,45,300);
  int ancho= 50;
  int espacio=50;
  int base=300;
  int x=70;
  
 strokeWeight(10);
  for(int i=0;i<datos.size();i++){
    float altura= datos.get(i);
    
    /*if(altura >100){
      stroke(255,0,0);
      fill(255,0,0);
    }else{
      stroke(random(255),random(255),random(255));
      fill(random(255),random(255),random(255));
    }*/
    stroke(0);
  //rect(x,base - altura,ancho,altura);//rectangulo para la grafica de barras, 300 son coordenadas que empiee el rectangulo, grosor de 10, altura de 100
  float y= 300 -altura*3;
  point(x,y);
  textSize(24);
  fill(200);
  text(altura, x+ancho/2, base-altura-10);
  x += ancho+espacio;
  }
 
}

void serialEvent(Serial puerto){
  dato = puerto.readStringUntil('\n');
  if(dato != null){
   dato = trim(dato);//limpia los datos si tiene espacios de mas los quita.
   float v= map(float(dato), 1,1000,1,1000);
   datos.add(v*5);
   println(dato);
   if(datos.size()>5){
    datos.remove(0); 
   }
  }
    
  
  
}
