
import processing.net.*;

Client cliente;
BufferedReader leer;
String dato="";
int r = 255;
int g = 255;
int b = 255;
ArrayList<Float> gra= new ArrayList<Float>();

void setup(){
 size(900,500);
 try{
   //192.168.16.203
  cliente = new Client(this,"192.168.16.202",12345);
  //leer= new BufferReader(new InputStreamReader(socket.getInputStream()));
  println("Concectado a la ESP32");
  
 }catch(Exception e){
   println("error en la conexion");
   
 }
}

void draw(){
  int ancho =50;
  int espacio = 100;
  int base=300;
  int x=0;
  //cliente.write("hola\n");
  background(255);
  textSize(40);
  fill(0,255,0);
  text("Grafiquita espectular, subete PAOLA!!!",15,35);
  if(cliente.available()>0){
   String mens =cliente.readStringUntil('\n');
   if(mens != null){
    dato= mens.trim();
    gra.add(float(dato));
      if (gra.size() > 50){
        gra.remove(0);
      }
   }
  }
  for(int i=0; i<gra.size();i++){
    float y= gra.get(i);
    stroke(255);
    rect(x, base - y,ancho, y);
    textSize(18);
    fill(0,255,0);
    text(y,x+ancho/2, base -y-20);
    x+= espacio;
  
  }
  
}
