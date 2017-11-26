Map map;
void setup(){
  //Window
  size(1680,1050);
  frameRate(60);
  //Map
  cellSetup();
  map = new Map().generate(10,10);
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