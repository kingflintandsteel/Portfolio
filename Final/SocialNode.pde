class SocialNetworkNode
{
  //variables
  Agent current;
  boolean painted;
  
  //constructor
  public SocialNetworkNode(Agent A){
    this.current = A;
    this.painted = false;
  }
  
  //painted
  public boolean painted(){
    return this.painted;
  }
  
  //paint
  public void paint(){
    this.painted = true;
  }
  
  //unpaint
  public void unpaint(){
    this.painted = false;
  }
  
  //getAgent
  public Agent getAgent(){
    return this.current;
  }
  
}
