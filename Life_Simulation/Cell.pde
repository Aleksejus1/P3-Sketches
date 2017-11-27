class Cell{
  float transition;
  CellType type;
  Cell U,D,L,R;
  ArrayList<Cell> neighbours;
  Cell(){
    transition = random(0f, 1f);
    R = U = D = L = null;
    neighbours = new ArrayList<Cell>();
  }
  Cell type(CellType type){
    this.type = type;
    return this;
  }
  void drawSide(Cell side, float x, float y, float w, float h, float t){
    if(side!=null){
      fill(lerpColor(getColor(),side.getColor(),t));
      rect(x, y, w, h);
    }
  }
  float addTransition(float ammount){
    float absorbing = min(1-transition, ammount);
    transition+=absorbing;
    return ammount-absorbing;
  }
  color getColor(){ return lerpColor(type.c1,type.c2,transition); }
  void update(){
    if(type==CellType.get(0)){
      float resources = addTransition(transition/20)+transition/100;
      float total = 0;
      for(Cell cell : neighbours) total+=1-cell.transition;
      if(total<resources) total=resources;
      for(Cell cell : neighbours) cell.transition+= (1-cell.transition)/total*resources;
    }
  }
}

class CellType{
  color c1,c2;
  CellType c1(color c){ c1 = c; return this; }
  CellType c2(color c){ c2 = c; return this; }
}

ArrayList<CellType> CellType = new ArrayList<CellType>();

void cellSetup(){
  registerCellType(new CellType().c1(color(160.f, 100.f, 0.f)).c2(color(80.f, 180.f, 0.f)));
}

void registerCellType(CellType type){
  CellType.add(type);
}