float dotSize = 10, map_rect_size;
Dot map;
Food food;
Snake snake;
Background bc;

void setup(){
  //Window
  size(1680, 1050);
  
  //Background
  bc = new Background(100, 30, 70, 5/3);
  
  //"MAP"
  map_rect_size = ((width<height)?width:height);
  map = new Dot((width-map_rect_size)/2,(height-map_rect_size)/2);
  
  //Other
  strokeWeight(1);
  textSize(30);
  food = new Food(dotSize*30/4);
  snake = new Snake();
}

float dist(Dot a, Dot b){ return dist(a.x,a.y,b.x,b.y); }

void keyPressed() {
  if(keyCode==107) snake.speed++;
  else if(keyCode==109) snake.speed--;
  else print(keyCode);
}

void mouseReleased() { snake.grow(); food.spawn(); }