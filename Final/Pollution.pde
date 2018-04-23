class PollutionRule
{
  //variables
  int gathering;
  int eating;
  
  //constructor
  public PollutionRule(int gathering, int eating){
    this.gathering = gathering;
    this.eating = eating;
  }
  
  //pollute
  public void pollute(Square S){
    if(S.getAgent() == null) return;
    else{
      int currentsugar = S.getSugar();
      int currentmetabolism = S.getAgent().getMetabolism();
      S.increasePollution(this.gathering*currentsugar);
      S.increasePollution(this.eating*currentmetabolism);
    }
  }
  
}
