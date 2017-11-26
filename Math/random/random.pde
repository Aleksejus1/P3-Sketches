void setup(){
  for(int i = 0; i<8; i++){
  for(int o = 0; o<8; o++){
  for(int p = 0; p<8; p++){
    if(161*i+295*o+411*p==3200) println("161*",i,"+295*",o,"+411*",p);
  }}}
  println("end");
  //println("end -", best1, best2, best3, best4);
}