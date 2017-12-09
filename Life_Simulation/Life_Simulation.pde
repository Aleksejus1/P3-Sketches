Map map;
void setup(){
  //Window
  size(1100,650);
  frameRate(60);
  randomSeed((((day()*24+hour())*60+minute())*60+second()+millis()));
  //Map
  cellSetup();
  map = new Map().generate(50,50);
  //Begin drawing
  nextFrame();
}
void draw(){
  if(random(0.f,1.f)<0.5f){
    map.update();
    nextFrame();
  }
}
void nextFrame(){
  background(255);
  map.draw(0,0);
}
void keyPressed(){
  if(key=='+') map.detailCount++;
  else if(key=='-') map.detailCount--;
  else if(keyCode==38) map.d++;//up
  else if(keyCode==40) map.d--;//down
  else {
    print(keyCode);
    print(' ');
    print(key);
    println();
  }
}