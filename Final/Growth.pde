interface GrowthRule
{
  public void growBack(Square S);
}

class GrowbackRule implements GrowthRule
{
  //variables
  int rate;
  
  //constructor
  public GrowbackRule(int rate){
    this.rate = rate;
  }
  
  //growBack
  public void growBack(Square S){
    S.setSugar(S.getSugar()+this.rate);
  }
  
}

class SeasonalGrowbackRule implements GrowthRule
{
  //variables
  int alpha;
  int beta;
  int gamma;
  int equator;
  int numsquares;
  boolean NorthSummer;
  int count;
  
  //constructor
  public SeasonalGrowbackRule(int A, int B, int G, int E, int NS){
    this.alpha = A;
    this.beta = B;
    this.gamma = G;
    this.equator = E;
    this.numsquares = NS;
    this.NorthSummer = true;
    this.count = 0;
  }
  
  //gorwBack
  public void growBack(Square S){
    if(S.getY() >= this.equator){
      if(NorthSummer == true){
        S.increaseSugar(this.alpha);
      }
      else S.increaseSugar(this.beta);
    }
    else if(S.getY() < this.equator){
      if(NorthSummer == true){
        S.increaseSugar(this.beta);
      }
      else S.increaseSugar(this.alpha);
    }
  }
  
  //NorthSummer
  public boolean NorthSummer(){
    return NorthSummer;
  }
  
}
