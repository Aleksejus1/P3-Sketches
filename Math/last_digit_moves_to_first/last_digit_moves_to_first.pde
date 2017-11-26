IntList digits = new IntList();
int best1, best2, best3;
double best4 = 1;

void inc(){
  digits.increment(0);
  int index = 0;
  while(digits.get(index)>9){
    if(digits.size()<=index+1) digits.append(1);
    else digits.increment(index+1);
    digits.set(index, 0);
    index++;
  }
}

void setup(){
  digits.append(0);
  for(int i = 0; i < 1000000000; i++){
    inc();
    int num1 = 0;
    for(int o = digits.size()-1; o>=0; o--) num1 = num1*10 + digits.get(o);
    int[] copy = digits.array();
    int first = copy[0];
    for(int o = 0; o<copy.length-1; o++) copy[o] = copy[o+1];
    copy[copy.length-1] = first;
    int num2 = 0;
    for(int o = copy.length-1; o>=0; o--) num2 = num2*10 + copy[o];
    int num3 = num1 * 2;
    double num4 = ((float)num3 / (float)num2)-1;
    if(num4<0) num4*=-1;
    if(num4<best4){
      best1 = num1;
      best2 = num2;
      best3 = num3;
      best4 = num4;
      //println(best1, best2, best3, best4);
    }
    if(num2==num3){
      println("Found it", num1, num2, num3, num2==num3);
    }
    //else print(num2, num3, "|");
  }
  println("end -", best1, best2, best3, best4);
  //while(true){
  //  if(!inc()) break;
  //}
}