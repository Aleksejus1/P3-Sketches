class Snake{
  ArrayList<Dot> body;
  float speed = 1;
  Snake(){
    body = new ArrayList<Dot>();
    for(int i = 0; i < 1; i++) body.add(new Dot(width/2, height/2));
  }
  void grow(){
    body.add(new Dot(body.get(body.size()-1)));
    speed+=0.2;
  }
  void update(){
    if(body.size()>0){
      body.get(0).travel(new Dot(mouseX, mouseY), speed);
      if(dist(body.get(0),food)<(dotSize+food.size)/2){
        food.spawn();
        grow();
      }
      for(int i = 1; i < body.size(); i++){
        Dot cell = body.get(i);
        Dot target = body.get(i-1);
        float z = dist(cell,target);
        if(z>dotSize){
          float ratio = (z-dotSize)/z;
          float xx = (target.x - cell.x)*ratio + cell.x;
          float yy = (target.y - cell.y)*ratio + cell.y;
          cell.travel(new Dot(xx, yy),speed);
        }
      }
    }
  }
  void draw(){
    fill(255);
    stroke(0);
    for(int i = body.size()-1; i >=0; i--){
      ellipse(body.get(i).x,body.get(i).y,dotSize,dotSize);
    }
  }
}