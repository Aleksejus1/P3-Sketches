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
    if(type==ct("Grass")){
      ArrayList<Cell> neighbourGrass = new ArrayList<Cell>();
      for(Cell cell : neighbours) if(cell.type==ct("Grass")) neighbourGrass.add(cell);
      float resources = addTransition(transition/20)+transition/100;
      float total = 0;
      for(Cell cell : neighbourGrass) total+=1-cell.transition;
      if(total<resources) total=resources;
      for(Cell cell : neighbourGrass) cell.transition+= (1-cell.transition)/total*resources;
    }
  }
}

class CellType{
  String name;
  color c1,c2;
  CellType(String name){
    this.name = name;
  }
  CellType c1(color c){ c1 = c; return this; }
  CellType c2(color c){ c2 = c; return this; }
}

ArrayList<CellType> CellType = new ArrayList<CellType>();

void cellSetup(){
  registerCellType(new CellType("Grass").c1(color(160.f, 100.f, 0.f)).c2(color(80.f, 180.f, 0.f)));
  registerCellType(new CellType("Stone").c1(color(186.f, 186.f, 186.f)).c2(color(112.f, 112.f, 112.f)));
}

CellType ct(String name){
  for(CellType c : CellType){
    if(c.name==name) return c;
  }
  println("["+name+"] is not a valid CellType - function ct(String name)");
  return null;
}

void registerCellType(CellType type){
  CellType.add(type);
}