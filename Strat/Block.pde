class Block{
  int Color = colors[0];
  int x,y,id=0;
  Block(int x, int y){
    this.x = x;
    this.y = y;
  }
  Block setId(int id){
    this.id = id;
    Color = colors[id];
    return this;
  }
  Block setColor(color c){
    Color = c;
    return this;
  }
  void show(){
    //stroke(Color);
    stroke(150);
    fill(Color);
    rect(x*size,y*size,size,size);
  }
}