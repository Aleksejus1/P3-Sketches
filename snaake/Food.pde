class Food extends Dot{
  float size;
  Food(float size){
    super(0,0);
    this.size = size;
    spawn();
  }
  void spawn(){
    this.x = random(map.x+size/2,map_rect_size+map.x-size/2);
    this.y = random(map.y+size/2,map_rect_size+map.y-size/2);
  }
  void draw(){
    noStroke();
    fill(64,256,64);
    ellipse(this.x,this.y,size,size);
  }
  void update(){
  }
}