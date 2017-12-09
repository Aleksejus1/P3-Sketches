class PosInt{
  int x, y;
  PosInt(){
    x=0;
    y=0;
  }
  PosInt(int x, int y){
    this.x = x;
    this.y = y;
  }
  PosInt pos(int x, int y){
    this.x = x;
    this.y = y;
    return this;
  }
}

class PosFloat{
  float x, y;
  PosFloat(){
    x=0;
    y=0;
  }
  PosFloat(float x, float y){
    this.x = x;
    this.y = y;
  }
  PosFloat pos(float x, float y){
    this.x = x;
    this.y = y;
    return this;
  }
}