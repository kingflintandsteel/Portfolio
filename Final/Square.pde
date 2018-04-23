public class Square
{
  //variables
  int x;
  int y;
  int sugarlevel;
  int maxsugarlevel;
  Agent current;
  int pollution;
  
  //constructor
  public Square(int sugarlevel, int maxsugarlevel, int x, int y){
    this.x = x;
    this.y = y;
    this.sugarlevel = sugarlevel;
    this.maxsugarlevel = maxsugarlevel;
    this.current = null;
    this.pollution = 0;
  }
  
  //display
  public void display(int size){
    strokeWeight(4);
    stroke(255);
    fill(255,255,255-this.sugarlevel/6.0*255);
    rect(this.x*size,this.y*size,size,size);
    if(this.current == null) return;
    this.current.display(this.x*size+size/2,this.y*size+size/2,size);
  }
  
  //ocupied
  public boolean occupied(){
    if(this.current != null) return true;
    else return false;
  }
  
  //gets
  //////////////////////////////////////////////////
  
  //sugar
  public int getSugar(){
    return this.sugarlevel;
  }
  
  //maxsugar
  public int getMaxSugar(){
    return this.maxsugarlevel;
  }
  
  //x
  public int getX(){
    return this.x;
  }
  
  //y
  public int getY(){
    return this.y;
  }
  
  //agent
  public Agent getAgent(){
    return this.current;
  }
  
  //pollution
  public int getPollution(){
    return this.pollution;
  }
  
  //sets
  //////////////////////////////////////////////////
  
  //sugar
  public void setSugar(int amount){
    this.sugarlevel = amount;
    if(this.sugarlevel < 0){ this.sugarlevel = 0; return; }
    if(this.sugarlevel > this.maxsugarlevel){ this.sugarlevel = this.maxsugarlevel; return; }
  }
  
  //maxsugar
  public void setMaxSugar(int amount){
    if(amount < 0){ this.maxsugarlevel = 0; return; }
    this.maxsugarlevel = amount;
  }
  
  //agent
  public void setAgent(Agent New){
    if(this.current != null){
      if(New == null || New == this.current){ this.current = New; return; }
      assert(1==0);
    }
    this.current = New;
  }
  
  //pollution
  public void setPollution(int amount){
    this.pollution = amount;
  }
  
  //increaseSugar
  public void increaseSugar(int amount){
    this.sugarlevel+=amount;
    if(this.sugarlevel < 0){ this.sugarlevel = 0; return; }
    if(this.sugarlevel > this.maxsugarlevel){ this.sugarlevel = this.maxsugarlevel; return; }
  }
  
  //increasePollution
  public void increasePollution(int amount){
    this.pollution+=amount;
  }
  
}
