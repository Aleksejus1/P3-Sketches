class Map{
  float cellOffset = 0, cellSize;
  int detailCount = 4, d = 8, totalSize = 0, drawSize;
  PosFloat center = new PosFloat();
  ArrayList<ArrayList<Cell>> map;
  Map(){
    drawSize = 10;
  }
  Map generate(Integer w, Integer h){
    center.x = w/2.f;
    center.y = h/2.f;
    cellSize = (width>height)?(height-(h+1)*cellOffset)/(drawSize+2):(width-(w+1)*cellOffset)/(drawSize+2);
    cellOffset += cellSize;
    map = new ArrayList<ArrayList<Cell>>();
    for(int y = 0; y < h; y++){
      ArrayList<Cell> line = new ArrayList<Cell>();
      for(int x = 0; x < w; x++) {
        String type = "Grass";
        if(random(1,3)>2) type = "Stone";
        if(type=="Stone") println("stone");
        line.add(new Cell().type(ct(type)));
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
    PosInt dimx = new PosInt(floor(center.x)-(drawSize/2+1), floor(center.x)+(drawSize/2));
    PosInt dimy = new PosInt(floor(center.y)-(drawSize/2+1), floor(center.y)+(drawSize/2));
    //Box
    for(int y = dimy.x; y <= dimy.y; y++){
      ArrayList<Cell> line = map.get(y);
      for(int x = dimx.x; x <= dimx.y; x++){
        Cell cell = line.get(x);
        fill(lerpColor(cell.type.c1,cell.type.c2,cell.transition));
        float xp = (x+1-dimx.x)*cellOffset+xOffset-cellSize;
        float yp = (y+1-dimy.x)*cellOffset+yOffset-cellSize;
        rect(xp, yp, cellSize, cellSize);
        fill(0);
        //text(str(cell.transition).substring(1, 5),xp+cellSize/6,yp+cellSize/3,xp+cellSize/4*3,yp+cellSize/4*3);
      }
    }
    //Smoothing
    for(int y = dimy.x; y <= dimy.y; y++){
      ArrayList<Cell> line = map.get(y);
      for(int x = dimx.x; x <= dimx.y; x++){
        Cell cell = line.get(x);
        float xp = (x+1-dimx.x+(drawSize+3))*cellOffset+xOffset-cellSize;
        float yp = (y+1-dimy.x)*cellOffset+yOffset-cellSize;
        for(int i = 0; i<detailCount; i++){
          float t = 1/(pow(2,i+1));
          cell.drawSide(cell.R, xp+cellSize*(d-1-i)/d, yp+cellSize*i/d,cellSize/d, cellSize-cellSize*2*i/d, t);
          cell.drawSide(cell.D, xp+cellSize*i/d, yp+cellSize*(d-1-i)/d, cellSize-cellSize*2*i/d, cellSize/d, t);
          cell.drawSide(cell.L, xp+cellSize*i/d, yp+cellSize*i/d, cellSize/d, cellSize-cellSize*2*i/d, t);
          cell.drawSide(cell.U, xp+cellSize*i/d, yp+cellSize*i/d, cellSize-cellSize*2*i/d, cellSize/d, t);
        }
      }
    }
    //Text Debug
    fill(0);
    float tsize = 30;
    textSize(tsize);
    for(int y = dimy.x; y <= dimy.y; y++){
      ArrayList<Cell> line = map.get(y);
      for(int x = dimx.x; x <= dimx.y; x++){
        Cell cell = line.get(x);
        String str = str(cell.transition);
        str = str.substring(1, min(5, str.length()));
        float dim = cellSize*5/12;
        float minSizeW = tsize/textWidth(str)*dim;
        float minSizeH = tsize/( textDescent()+textAscent())*dim;
        tsize = min(minSizeW, minSizeH);
        textSize(tsize);
        float xp = (x+1-dimx.x+(drawSize+3)*2)*cellOffset+xOffset-cellSize;
        float yp = (y+1-dimy.x)*cellOffset+yOffset-cellSize;
        text(str,xp+cellSize/6,yp+cellSize/3+dim-textDescent());
      }
    }
  }
}