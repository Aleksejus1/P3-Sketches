class Map{
  float cellOffset = 2, cellSize;
  ArrayList<ArrayList<Cell>> map;
  Map generate(Integer w, Integer h){
    cellSize = (width>height)?(height-(h+1)*cellOffset)/h:(width-(w+1)*cellOffset)/w;
    cellOffset += cellSize;
    map = new ArrayList<ArrayList<Cell>>();
    for(int y = 0; y < h; y++){
      ArrayList<Cell> line = new ArrayList<Cell>();
      for(int x = 0; x < w; x++) line.add(new Cell().type(CellType.get(0)));
      map.add(line);
    }
    return this;
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
        text(str(cell.transition).substring(1, 5),xp+cellSize/6,yp+cellSize/3,xp+cellSize/4*3,yp+cellSize/4*3);
      }
    }
  }
}