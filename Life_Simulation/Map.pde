class Map{
  float cellOffset = 0, cellSize;
  int detailCount = 4, d = 8, totalSize = 0;
  ArrayList<ArrayList<Cell>> map;
  Map generate(Integer w, Integer h){
    cellSize = (width>height)?(height-(h+1)*cellOffset)/h:(width-(w+1)*cellOffset)/w;
    cellOffset += cellSize;
    map = new ArrayList<ArrayList<Cell>>();
    for(int y = 0; y < h; y++){
      ArrayList<Cell> line = new ArrayList<Cell>();
      for(int x = 0; x < w; x++) {
        line.add(new Cell().type(CellType.get(0)));
        totalSize++;
      }
      map.add(line);
    }
    for(int y = 0; y < h; y++){
      ArrayList<Cell> line = map.get(y);
      for(int x = 0; x < w; x++){
        Cell cell = line.get(x);
        if(y>0) {
          cell.U = map.get(y-1).get(x);
          cell.neighbours.add(cell.U);
        }
        if(y<h-1){
          cell.D = map.get(y+1).get(x);
          cell.neighbours.add(cell.D);
        }
        if(x>0){
          cell.L = line.get(x-1);
          cell.neighbours.add(cell.L);
        }
        if(x<w-1){
          cell.R = line.get(x+1);
          cell.neighbours.add(cell.R);
        }
      }
    }
    return this;
  }
  void update(){
    int count = floor(random(1, sqrt(totalSize)));
    ArrayList<Cell> list = new ArrayList<Cell>();
    while(list.size()<count){
      int y = floor(random(0, map.size()));
      int x = floor(random(0, map.get(y).size()));
      Cell ran = map.get(y).get(x);
      boolean exists = false;
      for(Cell check : list) if(check==ran) {exists=true; break;}
      if(!exists){
        list.add(ran);
        break;
      }
    }
    for(Cell cell : list) cell.update();
  }
  void draw(float xOffset, float yOffset){
    noStroke();
    textSize(30);
    for(int y = 0; y < map.size(); y++){
      ArrayList<Cell> line = map.get(y);
      for(int x = 0; x < line.size(); x++){
        Cell cell = line.get(x);
        fill(lerpColor(cell.type.c1,cell.type.c2,cell.transition));
        float xp = (x+1)*cellOffset+xOffset-cellSize;
        float yp = (y+1)*cellOffset+yOffset-cellSize;
        rect(xp, yp, cellSize, cellSize);
        fill(0);
        //text(str(cell.transition).substring(1, 5),xp+cellSize/6,yp+cellSize/3,xp+cellSize/4*3,yp+cellSize/4*3);
      }
    }
    for(int y = 0; y < map.size(); y++){
      ArrayList<Cell> line = map.get(y);
      for(int x = 0; x < line.size(); x++){
        Cell cell = line.get(x);
        float xp = (x+1)*cellOffset+xOffset-cellSize;
        float yp = (y+1)*cellOffset+yOffset-cellSize;
        for(int i = 0; i<detailCount; i++){
          float t = 1/(pow(2,i+1));
          cell.drawSide(cell.R, xp+cellSize*(d-1-i)/d, yp+cellSize*i/d,cellSize/d, cellSize-cellSize*2*i/d, t);
          cell.drawSide(cell.D, xp+cellSize*i/d, yp+cellSize*(d-1-i)/d, cellSize-cellSize*2*i/d, cellSize/d, t);
          cell.drawSide(cell.L, xp+cellSize*i/d, yp+cellSize*i/d, cellSize/d, cellSize-cellSize*2*i/d, t);
          cell.drawSide(cell.U, xp+cellSize*i/d, yp+cellSize*i/d, cellSize-cellSize*2*i/d, cellSize/d, t);
        }
      }
    }
  }
}