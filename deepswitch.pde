import processing.serial.*; 
int delta = 0;
boolean[] status = new boolean[8];
String y;
int i = 0;
Serial leggi;
void setup(){
  
  size(500, 300);
  fill(50);
  rect(20, 80, 460, 150);
  fill(255);
  textSize(20);
  text("on", 30, 100);
  text("ECE", 430, 100);
  leggi = new Serial(this, Serial.list()[0], 9600);
   spine();
   frameRate(30);
}
void spine(){
  delta = 0;
  for(i = 0; i < 8; i++){
    fill(100);
    rect(delta+30, 120, 40, 80);
    if(status[i] == false){
      fill(255,0,0);
      rect(delta+30, 120, 40, 40);
    }
    else{
      fill(0,255,0);
      rect(delta+30, 160, 40, 40);
    }
    text(str(i), delta+40, 225);
    delta += 57;
  }
}
void draw(){
  if(leggi.available() > 0){
     y = leggi.readStringUntil('\n');

     if(y != null){
       for(i = 7; i >= 0; i--){
         status[i] = bitSelect(Integer.parseInt(y.trim()), i);
         printArray(status);
       }
       spine();
     }
   }
}
boolean bitSelect(int num, int index){
  return ((num &(1 << index)) != 0);
}
