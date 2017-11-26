int strokeOutside = 4;
int strokeInside = 3;
int angleChange = 6;//15; //35octagon|60hex|72pent|90square|120triangle
int dist = 10;
int limit = 1592;
int outline = 200;
int w,h;
boolean debug=false;
boolean redraw=false;
float x1,y1,x2,y2;
boolean updateScheduled = true;
public class Position{
  public float x,y;
  public Position(){
    this.x = 0;
    this.y = 0;
  }
}
public class Point{
  public int number;
  public float angle = 70;
  public Position pos = new Position();
  public ArrayList<Point> to = new ArrayList<Point>();
  public Point from = null;
  public Point(int num){
    this.number = num;
  }
  public void drawLines(boolean draw){
    if(from!=null){
      if(from.number%2==0) from.angle = angle - angleChange;
      else from.angle = angle + angleChange;
      from.pos.y = pos.y - sin(radians(from.angle));
      from.pos.x = pos.x + cos(radians(from.angle));
      if(draw) line(pos.x*dist,pos.y*dist,from.pos.x*dist,from.pos.y*dist);
      else{
        if(pos.x>x2) x2=pos.x;
        if(pos.x<x1) x1=pos.x;
        if(pos.y>y2) y2=pos.y;
        if(pos.y<y1) y1=pos.y;
      }
      from.drawLines(draw);
    }
  }
  public void generateAngles(){
    for(Point n: to){
      if(n.number%2==0) n.angle = angle - angleChange;
      else n.angle = angle + angleChange;
      n.pos.y = pos.y - sin(radians(n.angle));
      n.pos.x = pos.x + cos(radians(n.angle));
      n.generateAngles();
      if(n.pos.x>x2) x2=n.pos.x;
      if(n.pos.x<x1) x1=n.pos.x;
      if(n.pos.y>y2) y2=n.pos.y;
      if(n.pos.y<y1) y1=n.pos.y;
    }
  }
}

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> armEnds = new ArrayList<Point>();

void setup(){
  frameRate(60);
  size(1600,950);
  surface.setResizable(true);
  w = width;
  h = height;
  fill(0);
  generatePoints();
}

void generatePoints(){
  points.clear();
  //addPoint(1);
  points.add(new Point(1));
  for(int i =2; i <= limit; i++){
    if(!pointExists(i)) addPointEX(i);
  }
  armEnds.clear();
  for(Point p: points) if(p.to.size()==0) armEnds.add(p);
}

int addPointEX(int p){
  points.add(new Point(p));
  int id = points.size()-1;
  int next = ((p%2==0)?p:p*3+1)/2;
  int nextId;
  if(pointExists(next)){
    nextId = getPoint(next);
  }
  else{
    nextId = addPointEX(next);
  }
  points.get(nextId).to.add(points.get(id));
  points.get(id).from = points.get(nextId);
  return id;
}

int addPoint(int p){
  points.add(new Point(p));
  int id = points.size()-1;
  int next = p*2;
  int nextId;
  if(next<limit){
    nextId = addPoint(next);
    points.get(id).to.add(points.get(nextId));
    points.get(nextId).from = points.get(id);
  }
  if((next-1)%3==0){
    next = (next-1)/3;
    if(next<limit&&!pointExists(next)){
      nextId = addPoint(next);
      points.get(id).to.add(points.get(nextId));
      points.get(nextId).from = points.get(id);
    }
  }
  return id;
}

boolean pointExists(int p){
  for(Point po: points) if(po.number==p) return true;
  return false;
}

int getPoint(int p){
  for(int i = 0; i < points.size(); i++) if(points.get(i).number==p) return i;
  return -1;
}

void update(){
  updateScheduled = true;
}

void draw(){
  if(redraw){
    redraw = false;
    background(255);
    if(debug){
      text("strokeOutside[1;4] = "+strokeOutside,20,20);
      text("strokeInside[2;5] = "+strokeInside,20,30);
      text("angleChange[3;6] = "+angleChange,20,40);
      text("distance[0;Dot] = "+dist,20,50);
      text("limit[Spacebar] = "+limit,20,60);
    }
    translate(-x1*dist,-y1*dist);
    for(int i = armEnds.size()-1; i >= 0 ; i--){
      strokeWeight(strokeOutside);
      stroke(0);
      armEnds.get(i).drawLines(true);
      strokeWeight(strokeInside);
      stroke(255);
      armEnds.get(i).drawLines(true);
    }
  }
  if(updateScheduled){
    updateScheduled = false;
    x1=1000;y1=1000;x2=-1000;y2=-1000;
    for(int i = armEnds.size()-1; i >= 0 ; i--) armEnds.get(i).drawLines(false);
    //points.get(getPoint(1)).generateAngles();
    x1-=outline/dist;y1-=outline/dist;x2+=outline/dist;y2+=outline/dist;
    surface.setSize(int((x2-x1)*dist),int((y2-y1)*dist));
    w = width;
    h = height;
    redraw = true;
  }
}

void drawLine(int from, int to){
  line(0,from*10,0,to*10);
}
void keyPressed() {
  update();
  if(keyCode==97) strokeOutside--; else
  if(keyCode==100) strokeOutside++; else
  if(keyCode==98) strokeInside--; else
  if(keyCode==101) strokeInside++; else
  if(keyCode==99) angleChange--; else
  if(keyCode==102) angleChange++; else
  if(keyCode==96) dist--; else
  if(keyCode==110) dist++; else
  if(keyCode==10) debug=!debug; else
  if(keyCode==32){
    limit++;
    generatePoints();
  } else
  if(keyCode==16){
    limit--;
    generatePoints();
  }
  else{
    if(keyCode==107) save("colatz-"+strokeOutside+"_"+strokeInside+"_"+angleChange+"_"+dist+"_"+limit+"_"+outline+".png");
    else println("Keycode =",keyCode);
    updateScheduled = false;
  }
}