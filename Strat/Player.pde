class Player{
  float x,y,speed;
  Player(float x, float y, float speed){
    this.x = x;
    this.y = y;
    this.speed = speed;
  }
  void show(){
    stroke(0);
    fill(0,255,150);
    ellipse((x)*size,(y)*size,size,size);
  }
  void move(){
    x += ((isPressed('d')?1:0)-(isPressed('a')?1:0))*speed*(isPressed(SHIFT)?1.5:1)/frameRate;
    y += ((isPressed('s')?1:0)-(isPressed('w')?1:0))*speed*(isPressed(SHIFT)?1.5:1)/frameRate;
  }
  public String saveData(){
    String s = "";
    s+=x+" "+y+" "+speed;
    return s;
  }
}