class Cell{
  PVector pos = new PVector();
  boolean[] sides = {true, true, true, true};
  boolean visited = false;
  
  Cell(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  void show(int size){
    stroke(0);
    if(sides[0]) line(pos.x*size, pos.y*size, (pos.x+1)*size, pos.y*size);
    if(sides[1]) line((pos.x+1)*size, pos.y*size, (pos.x+1)*size, (pos.y+1)*size);
    if(sides[2]) line((pos.x+1)*size, (pos.y+1)*size, pos.x*size, (pos.y+1)*size);
    if(sides[3]) line(pos.x*size, (pos.y+1)*size, pos.x*size, pos.y*size);
  }
}