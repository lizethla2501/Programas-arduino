void setup() {
  
    Serial.begin(115200);

}

void loop() {
  
  float dato= random(1,500)*1.0;
  float dato1= map(dato,1,500,1,50);
  float dato2=map(dato,1,500,50,100);
  //Serial.print("dato:" );
  Serial.println(dato);
//Serial.print("dato 1:" );
  //Serial.println(dato1);
//Serial.print("dato 2:" );
  //Serial.println(dato2);
  delay(500);
}
