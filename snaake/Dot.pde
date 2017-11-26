class Dot{
  float x,y;
  Dot(float x, float y){
    this.x = x;
    this.y = y;
  }
  Dot(Dot a){
    this.x = a.x;
    this.y = a.y;
  }
  void travel(Dot target, float max_distance){
    float x = target.x-this.x;
    float y = target.y-this.y;
    float z = dist(this,target);
    if(z>max_distance){
      float ratio = max_distance/z;
      x *= ratio;
      y *= ratio;
    }
    this.x += x;
    this.y += y;
  }
}