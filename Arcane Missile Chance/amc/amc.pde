

void setup(){
  
  IntList targets = new IntList();
  
  int tryCount = 10000000;
  int minShots = 3;
  int maxShots = 10;
  boolean fullInfo = false;
  
  for(int shotCount = minShots; shotCount <= maxShots; shotCount++){
    int kills = 0;
    for(int attempt = 0; attempt<tryCount; attempt++){
      targets.append(4);
      targets.append(30);
      for(int i=0; i<shotCount; i++){
        int target = int(random(targets.size()));
        targets.sub(target,1);
        if(targets.get(target)<=0){
          targets.remove(target);
          kills++;
          break;
        }
      }
      targets.clear();
    }
    
    float chance = float(kills)/float(tryCount);
    int divisor = int(pow(2,shotCount));
    int divident = round(chance*divisor);
    int d = DBD(divident,divisor);
    divisor/=d;
    divident/=d;
    if(shotCount!=minShots) print("\n\n");
    if(fullInfo){
      println("SHOTS -", shotCount);
      println("        ", kills, "/", tryCount);
      println("        ", chance);
      println("        ", chance*100, "%");
      println("        ", divident, "/", divisor);
    }
    else{
      println("SHOTS\t-\t", shotCount);
      println("CHANCE\t-\t", divident, "/", divisor, "\t\t-\t", chance*100, "%");
    }
  }
}

int DBD(int sk1, int sk2){
  if (sk2 == 0) return sk1;
  else return DBD(sk2, sk1 % sk2);
}