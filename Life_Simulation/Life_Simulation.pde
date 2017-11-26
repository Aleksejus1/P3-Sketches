Map map;
void setup(){
  //Window
  size(1680,1050);
  //Map
  cellSetup();
  map = new Map().generate(10,10);
}

void draw(){
  map.draw(0,0);
}