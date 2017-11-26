class Background{
  int activeCount = 0;
  double from, to, change, xRatio, yRatio;
  BackgroundState[] states;
  
  Background(int stateCount, double from, double to, double change){
    states = new BackgroundState[stateCount];
    this.from = from;
    this.to = to;
    this.change = change;
    this.xRatio = ((width/2)-1)/stateCount;
    this.yRatio = ((height/2)-1)/stateCount;
  }
  
  void draw(){
    noStroke();
    for(int i = 0; i<activeCount; i++){
      fill((int)states[i].col);
      rect((float)(i*xRatio),(float)(i*yRatio),(float)(width-i*xRatio*2),(float)(height-i*yRatio*2));
    }
  }
  
  void update(){
    if(activeCount<states.length){
      states[activeCount] = new BackgroundState(from, 1);
      activeCount++;
    }
    for(int i = 0; i<activeCount; i++){
      if(states[i].col>to|states[i].col<from) states[i].state*=-1; //Change state/direction
      states[i].col+=states[i].state*change; //Move color along the direction/state
    }
  }
}

class BackgroundState{
  double col;
  int state;
  
  BackgroundState(double col, int state){
    this.col = col;
    this.state = state;
  }
}