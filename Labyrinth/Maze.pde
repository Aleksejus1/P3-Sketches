class Maze {
  Cell[][] grid;
  int cellSize;
  int[] end, start = new int[2];
  int state = -1;
  PVector[] fowOuter = {new PVector(0, 0), new PVector(0, height), new PVector(width, height), new PVector(width, 0)};
  ArrayList<int[]> steps = new ArrayList<int[]>();
  Maze(int size) {
    cellSize = size;
  }
  void reset(){
    state = -1;
    steps.clear();
  }
  void generate(int cols, int rows, int startX, int startY) {
    reset();
    start[0] = startX;
    start[1] = startY;
    int[] newStep = {start[0],start[1]};
    steps.add(newStep);
    grid = new Cell[cols][rows];
    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        grid[c][r] = new Cell(c, r);
      }
    }
    Pather pather = new Pather(start[0], start[1], cellSize, this.grid);
    do {
      pather.update();
    } while (pather.stack.size()>0);
    end = pather.furthest;
    print("Closest path: ", pather.biggestStack, '\n');
  }
  void show() {
    if (state==-1){
      for (int c = start[0]-1; c <= start[0]+1 && c < grid.length; c++) {
        if(c<0) c = 0;
        for (int r = start[1]-1; r <= start[1]+1 && r < grid[c].length; r++) {
          if(r<0) r = 0;
          grid[c][r].show(cellSize);
        }
      }
      fogOfWar();
      showSteps();
    }
    else{
      if (state<100) state++;
      for (int c = 0; c < grid.length; c++) {
        for (int r = 0; r < grid[c].length; r++) {
          grid[c][r].show(cellSize);
        }
      }
      showSteps();
      fogOfWar(state);
    }
    stroke(0);
    strokeWeight(1);
    fill(255, 150, 0);
    ellipse((end[0]+0.5)*cellSize, (end[1]+0.5)*cellSize, cellSize*0.7, cellSize*0.7);//Exit
    fill(0, 150, 255);
    ellipse((start[0]+0.5)*cellSize, (start[1]+0.5)*cellSize, cellSize*0.6, cellSize*0.6);//"Player"
    if(state!=-1){
      fill(249, 208, 0);
      textSize(128);
      text("Victory",width/4,height/2+height/15);
      textSize(32);
      fill(213, 178, 0);
      text("Press any key to continue...",width/5,height/2+height/8);
    }
  }
  void showSteps(){
    stroke(100,255,100);
    strokeWeight(2);
    for(int i = 1; i < steps.size(); i++) line((steps.get(i-1)[0]+0.5)*cellSize,(steps.get(i-1)[1]+0.5)*cellSize,(steps.get(i)[0]+0.5)*cellSize,(steps.get(i)[1]+0.5)*cellSize);
  }
  void move(int dir) {
    int[] newPos = {start[0], start[1]};
    switch(dir) {
    case 0: 
      newPos[1]--; 
      break;
    case 1: 
      newPos[0]++; 
      break;
    case 2: 
      newPos[1]++; 
      break;
    case 3: 
      newPos[0]--; 
      break;
    }
    if (newPos[0]>=0&&newPos[1]>=0&&newPos[0]<grid.length&&grid.length>0&&newPos[1]<grid[0].length&&!grid[start[0]][start[1]].sides[dir]) {
      start = newPos;
      steps.add(newPos);
      if (start[0]==end[0]&&start[1]==end[1]) {
        win();
      }
    }
  }
  void win() {
    state = 0;
  }
  void fogOfWar(int precent) {
    float offset = 0.1, offset2 = (1+offset*2)*unitSize;
    PVector[] fowInner = new PVector[4];
    fowInner[0] = new PVector((maze.start[0]-offset)*unitSize, (maze.start[1]-offset)*unitSize);
    fowInner[1] = new PVector(fowInner[0].x+offset2, fowInner[0].y);
    fowInner[2] = new PVector(fowInner[1].x, fowInner[1].y+offset2);
    fowInner[3] = new PVector(fowInner[2].x-offset2, fowInner[2].y);
    float adj = map(precent, 0, 100, 0, 1);
    adjust(fowInner[0],fowOuter[0],adj);
    adjust(fowInner[1],fowOuter[3],adj);
    adjust(fowInner[2],fowOuter[2],adj);
    adjust(fowInner[3],fowOuter[1],adj);
    fill(0, 0, 0, 255);
    noStroke();
    drawHole(fowOuter, fowInner);
  }
  void adjust(PVector a, PVector b, float p){
    a.x -= (a.x-b.x)*p;
    a.y -= (a.y-b.y)*p;
  }
  void fogOfWar() {
    float offset = 0.1, offset2 = (1+offset*2)*unitSize;
    PVector[] fowInner = new PVector[4];
    fowInner[0] = new PVector((maze.start[0]-offset)*unitSize, (maze.start[1]-offset)*unitSize);
    fowInner[1] = new PVector(fowInner[0].x+offset2, fowInner[0].y);
    fowInner[2] = new PVector(fowInner[1].x, fowInner[1].y+offset2);
    fowInner[3] = new PVector(fowInner[2].x-offset2, fowInner[2].y);
    fill(0, 0, 0, 255);
    noStroke();
    drawHole(fowOuter, fowInner);
  }
  void drawHole(PVector[] outer, PVector[] inner) {
    if (outer.length>0&&inner.length>0) {
      beginShape();
      vertex(outer[0].x, outer[0].y);
      for (PVector pos : inner) vertex(pos.x, pos.y);
      vertex(inner[0].x, inner[0].y);
      for (PVector pos : outer) vertex(pos.x, pos.y);
      endShape( CLOSE );
    }
  }
}