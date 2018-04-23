class ReplacementRule
{
  //variables
  int min;
  int max;
  AgentFactory fac;
  HashMap<Agent,Integer> L;
  
  //constructor
  public ReplacementRule(int minAge, int maxAge, AgentFactory fac){
    this.min = minAge;
    this.max = maxAge;
    this.fac = fac;
    this.L = new HashMap(30);
  }
  
  //replaceThisOne
  public boolean replaceThisOne(Agent A){
    if(!this.L.containsKey(A)){
      int life = (int)random(this.min,this.max);
      this.L.put(A,life);
    }
    int age = A.getAge();
    int maxAge = this.L.get(A);
    if(age > maxAge){
      this.L.put(A,maxAge+1);
      return true;
    }
    if(!A.isAlive()){
      return true;
    }
    return false;
  }
  
  //replace
  public Agent replace(Agent A, List<Agent> others){
    return this.fac.makeAgent();
  }
  
}
