public class Agent
{
  //variables
  int metabolism;
  int vision;
  int sugarlevel;
  MovementRule move;
  int age;
  char sex;
  
  //constructor
  public Agent(int metabolism, int vision, int sugarlevel, MovementRule move){
    this.metabolism = metabolism;
    this.vision = vision;
    this.sugarlevel = sugarlevel;
    this.move = move;
    this.age = 0;
    if((int)random(0,1) == 1) this.sex = 'X';
    else this.sex = 'Y';
  }
  
  //constructor #2
  public Agent(int metabolism, int vision, int sugarlevel, MovementRule move, char sex){
    this.metabolism = metabolism;
    this.vision = vision;
    this.sugarlevel = sugarlevel;
    this.move = move;
    this.age = 0;
    this.sex = sex;
    if(!(this.sex == 'X' || this.sex == 'Y')) assert(1==0);
  }
  
  //move
  public void move(Square Source, Square Destination){
    if(Destination.getAgent() != null && Destination.getAgent() != this){}
    else{
      Source.setAgent(null);
      Destination.setAgent(this);
    }
  }
  
  //step
  public void step(){
    this.sugarlevel-=this.metabolism;
    if(this.sugarlevel < 0) this.sugarlevel = 0;
    this.age++;
  }
  
  //isAlive
  public boolean isAlive(){
    if(this.sugarlevel > 0) return true;
    else return false;
  }
  
  //eat
  public void eat(Square s){
    this.sugarlevel+=s.getSugar();
    s.setSugar(0);
  }
  
  //display
  public void display(int x, int y, int scale){
    strokeWeight(1);
    fill(0);
    stroke(0);
    ellipse(x,y,3*scale/4,3*scale/4);
  }
  
  //gift
  public void gift(Agent other, int amount){
    if(this.sugarlevel >= amount){
      other.increaseSugarLevel(amount);
      this.decreaseSugarLevel(amount);
    }
  }
  
  //gets
  ////////////////////////////////////////////////
  
  //metabolism
  public int getMetabolism(){
    return this.metabolism;
  }
  
  //vision
  public int getVision(){
    return this.vision;
  }
  
  //sugarlevel
  public int getSugarLevel(){
    return this.sugarlevel;
  }
  
  //movementrule
  public MovementRule getMovementRule(){
    return this.move;
  }
  
  //age
  public int getAge(){
    return this.age;
  }
  
  //sex
  public char getSex(){
    return this.sex;
  }
  
  //sets
  ///////////////////////////////////////////////
  
  //age
  public void setAge(int count){
    if(count < 0) assert(1==0);
    this.age=count;
  }
  
  //sugarlevel
  public void setSugarLevel(int amount){
    this.sugarlevel = amount;
  }
  
  //increasesugarlevel
  public void increaseSugarLevel(int amount){
    this.sugarlevel+=amount;
  }
  
  //decreasesugarlevel
  public void decreaseSugarLevel(int amount){
    this.sugarlevel-=amount;
  }
  
}
