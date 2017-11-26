class Cell{
  float transition;
  CellType type;
  Cell(){
    transition = random(0f, 1f);
  }
  Cell type(CellType type){
    this.type = type;
    return this;
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