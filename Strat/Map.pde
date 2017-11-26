class Map{
  private Block[][] block;
  private int w, h;
  public Player player;
  Map(int w, int h){
    this.w = w; this.h = h;
    if(w!=0&&h!=0){
      initBlocks();
      player = new Player(h/2,h/2,5);
    }
  }
  Map(String b, String p){
    String[] ba = b.split("\\s+"), pa = p.split("\\s+");
    this.w = int(ba[0]);
    this.h = int(ba[1]);
    initBlocks();
    int counter = 2;
    for(Block[] Ba : block) for(Block B: Ba){
      B.setColor(color(int(ba[counter]),int(ba[counter+1]),int(ba[counter+2])));
      counter+=3;
    }
    player = new Player(float(pa[0]),float(pa[1]),float(pa[2]));
  }
  public String saveData(){
    String s = "";
    s+=w+" "+h;
    for(Block[] ba: block) for(Block b: ba) s+=" "+red(b.Color)+" "+green(b.Color)+" "+blue(b.Color);
    return s;
  }
  public void show(int x, int y, int lenX, int lenY){
    showBlocks(x,y,lenX,lenY);
    player.show();
  }
  private void initBlocks(){
    block = new Block[w][h];
    for(int x = 0; x<w; x++) for(int y = 0; y<h; y++) block[x][y] = new Block(x,y).setId(1);
    //for(int x = 0; x<w; x++) for(int y = 0; y<h; y++) block[x][y] = new Block(x,y).setColor(color(map(x,0,w,0,255),map(y,0,h,0,255),map(x,0,w,255,0)));
  }
  private void showBlocks(int x, int y, int lenX, int lenY){ for(int px = x; px < x+lenX; px++) for(int py = y; py < y+lenY; py++) if(inRange(px,py,w,h)) block[px][py].show(); }
  public Block gBlock(int x, int y){ return (inRange(x,y,w,h))?block[x][y]:null; }
  public void sBlock(int x, int y, Block b){ if(inRange(x,y,w,h)) block[x][y] = b; }
  public boolean inRange(int x, int y, int w, int h){ return x>=0 && x<w && y>=0 && y<h; }
}