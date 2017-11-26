final int[] colors = {color(0), color(165,216,89)};
final float IOVersion = 1.1;
int size;
Map map;
ArrayList<Character> pressedKeys = new ArrayList<Character>();
ArrayList<Integer> pressedCodes = new ArrayList<Integer>();

void setup(){
  size(800,800);
  if(!load()){
    size = 40;
    map = new Map(40,40);
  }
}

void draw(){
  PVector offset = new PVector(width/2-(map.player.x)*size,height/2-(map.player.y)*size);
  translate(offset.x,offset.y);//Map
  background(255);
  map.show(floor(map.player.x - width/size/2 - 1), floor(map.player.y - height/size/2 -1),  floor(width/size)+3, floor(height/size)+3);
  map.player.move();
  translate(-offset.x,-offset.y);//UI
  String pos = "["+floor(map.player.x)+";"+floor(map.player.y)+"]";
  fill(255); rect(0,0,pos.length()*7,30);
  fill(0);   text(pos,6,20);
}

void dispose(){ save(); }

void save(){
  String[] save = new String[4];
  //Always first line is version
  save[0] = Float.toString(IOVersion); //1.0:
  save[1] = saveData();                //#2 = global
  save[2] = map.saveData();            //#3 = blocks
  save[3] = map.player.saveData();     //#4 = player
  saveStrings("save.txt",save);
}
boolean load(){
  String lines[] = loadStrings("save.txt");
  if(lines.length>0&&float(lines[0])==IOVersion){
    size = int(lines[1]);
    map = new Map(lines[2],lines[3]);
    return true;
  }
  else return false;
}
String saveData(){
  String s = "";
  s+=size;
  return s;
}

void keyPressed(){
  if(key==CODED) { if(pressedCodes.indexOf(keyCode)==-1) pressedCodes.add(keyCode); }
  else{
    key=Character.toLowerCase(key);
    if(pressedKeys.indexOf(key)==-1) pressedKeys.add(key);
    if(key=='e'){
      color c = map.block[floor(map.player.x)][floor(map.player.y)].Color;
      print("[",red(c),";",green(c),";",blue(c),"]\n");
    }
    else if(key=='c'){
      color c = map.block[floor(map.player.x)][floor(map.player.y)].Color;
      map.block[floor(map.player.x)][floor(map.player.y)].Color = color(red(c)/2,green(c)/2,blue(c)/2);
    }
  }
}
void keyReleased(){
  if(key==CODED) pressedCodes.remove(pressedCodes.indexOf(keyCode));
  else{
    key=Character.toLowerCase(key);
    pressedKeys.remove(pressedKeys.indexOf(key));
  }
}
boolean isPressed(Character c){ return pressedKeys.indexOf(c)!=-1||pressedKeys.indexOf(Character.toUpperCase(c))!=-1; }
boolean isPressed(Integer i){ return pressedCodes.indexOf(i)!=-1; }