class AgentFactory
{
  //variables
  int minMetabolism;
  int maxMetabolism;
  int minVision;
  int maxVision;
  int minInitialSugar;
  int maxInitialSugar;
  MovementRule M;
  
  //constructor
  public AgentFactory(int minM, int maxM, int minV, int maxV, int minS, int maxS, MovementRule M){
    this.minMetabolism = minM;
    this.maxMetabolism = maxM;
    this.minVision = minV;
    this.maxVision = maxV;
    this.minInitialSugar = minS;
    this.maxInitialSugar = maxS;
    this.M = M;
  }
  
  //makeAgent
  public Agent makeAgent(){
    int meta = (int)random(this.minMetabolism,this.maxMetabolism);
    int vis = (int)random(this.minVision,this.maxVision);
    int sug = (int)random(this.minInitialSugar,this.maxInitialSugar);
    return new Agent(meta,vis,sug,this.M);
  }
  
}
