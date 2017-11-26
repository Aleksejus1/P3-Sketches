void draw(){
  update();
  bc.draw();
  draw_map();
  snake.draw();
  food.draw();
  draw_debug();
}

int debugCounter;
void draw_debug(){
  fill(255);
  debugCounter = 0;
  //debugText("FPS: " + (int)frameRate);
  debugText("Cells: " + (int)snake.body.size());
  debugText("Speed: " + (int)(snake.speed*10)/10.f);
}

void debugText(String info){
  debugCounter++;
  text(info, 10, 30*debugCounter);
}

void draw_map(){
  noStroke();
  fill(128,128,128,64);
  rect(map.x,map.y,map_rect_size,map_rect_size);
}