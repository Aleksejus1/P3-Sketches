
Maze maze;
int unitSize = 100;

void setup(){
  frameRate(60);
  size(800,600);
  maze = new Maze(unitSize);
  int cols = width/unitSize, rows = height/unitSize;
  maze.generate(cols, rows, int(random(0,cols)) , int(random(0,rows)));
}

void draw(){
  background(255);
  maze.show();
}

void keyPressed(){
  if(maze.state==-1){
    if(key == 'w') maze.move(0);
    else if(key == 'd') maze.move(1);
    else if(key == 's') maze.move(2);
    else if(key == 'a') maze.move(3);
  }
  else{
    unitSize -= 10;
    maze.cellSize = unitSize;
    int cols = width/unitSize, rows = height/unitSize;
    maze.generate(cols, rows, int(random(0,cols)) , int(random(0,rows)));
  }
}