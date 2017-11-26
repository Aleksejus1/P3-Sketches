class Pather{
  Cell[][] grid;
  int[] pos = new int[2];
  int[] furthest = new int[2];
  ArrayList<int[]> stack = new ArrayList<int[]>();
  int cellSize, cols, rows, biggestStack = 0;
  
  Pather(int x, int y, int size, Cell[][] gridRef){
    pos[0] = x;
    pos[1] = y;
    cellSize = size;
    grid = gridRef;
    cols = grid.length;
    if(cols>0) rows = grid[0].length;
    else rows = 0;
  }
  void show(){
    noStroke();
    fill(100,255,100,100);
    rect(pos[0]*cellSize,pos[1]*cellSize,cellSize,cellSize);
  }
  void update(){
    grid[pos[0]][pos[1]].visited = true;
    ArrayList<Integer> neighbors = getNeighbors();
    if(neighbors.size()>0){
    int[] newStackItem = {pos[0], pos[1]};  
    stack.add(newStackItem);
      int next = neighbors.get(int(random(0,neighbors.size())));
      grid[pos[0]][pos[1]].sides[next] = false;
      switch(next){
        case 0: pos[1]--; break; case 1: pos[0]++; break;
        case 2: pos[1]++; break; case 3: pos[0]--; break;
      }
      grid[pos[0]][pos[1]].sides[(next+2)%4] = false;
    }
    else if(stack.size()>0){
      if(stack.size()>biggestStack){
        biggestStack = stack.size();
        furthest[0] = pos[0];
        furthest[1] = pos[1];
      }
      pos = stack.remove(stack.size()-1);
    }
  }
  ArrayList<Integer> getNeighbors(){
    ArrayList<Integer> n = new ArrayList<Integer>();
    if(pos[0]-1>=0 && !grid[pos[0]-1][pos[1]].visited) n.add(3);
    if(pos[0]+1<cols && !grid[pos[0]+1][pos[1]].visited) n.add(1);
    if(pos[1]-1>=0 && !grid[pos[0]][pos[1]-1].visited) n.add(0);
    if(pos[1]+1<rows && !grid[pos[0]][pos[1]+1].visited) n.add(2);
    return n;
  }
}