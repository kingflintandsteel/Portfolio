abstract class CDFGraph extends Graph
{
  //variables
  int CPV;
  int numUpdates;
  int HowWide;
  int X;
  int Y;
  
  //constructor
  public CDFGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab, int callsPerValue){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.CPV = callsPerValue;
    this.numUpdates = 0;
    this.HowWide = HowWide;
    this.X = X;
    this.Y = Y;
  }
  
  //reset
  public abstract void reset(SugarGrid G);
  
  //nextPoint
  public abstract int nextPoint(SugarGrid G);
  
  //getTotalCalls
  public abstract int getTotalCalls(SugarGrid G);
  
  //update
  public void update(SugarGrid G){
    int numPerCell;
    this.numUpdates = 0;
    super.update(G);
    reset(G);
    if(getTotalCalls(G)!=0) numPerCell = this.HowWide/getTotalCalls(G);
    else numPerCell = 0;
    while(numUpdates < getTotalCalls(G)){
      strokeWeight(1);
      rectMode(CORNER);
      rect((numUpdates*numPerCell)+this.X,nextPoint(G),numPerCell,1);
      numUpdates++;
    }
  }
  
}

class WealthCDF extends CDFGraph
{
  //variables
  ArrayList<Agent> sorted;
  int totalSugar;
  int sugarSoFar;
  int CPV;
  
  //constructor
  public WealthCDF(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab, int callsPerValue){
    super(X,Y,HowWide,HowTall,Xlab,Ylab,callsPerValue);
    totalSugar = 0;
    this.CPV = callsPerValue;
  }
  
  //reset
  public void reset(SugarGrid G){
    Sorter R = new QuickSorter();
    totalSugar = 0;
    sorted = G.getAgents();
    R.sort(sorted);
    for(Agent i:sorted){
      totalSugar+=i.getSugarLevel();
    }
    sugarSoFar = 0;
  }
  
  //nextPoint
  public int nextPoint(SugarGrid G){
    int currentAgents = (numUpdates)*this.CPV;
    int AverageSugar = 0;
    for(int i = currentAgents; i < this.CPV+currentAgents && i < sorted.size(); i++){
      AverageSugar+= sorted.get(i).getSugarLevel();
    }
    AverageSugar /= this.CPV;
    sugarSoFar += AverageSugar;
    double temp = (double)sugarSoFar/totalSugar;
    temp*=-this.Height;
    temp-=(temp/this.Height);
    temp*=3;
    temp+=this.y; 
    temp+=this.Height; 
    return (int)temp;
  }
  
  //getTotalCalls
  public int getTotalCalls(SugarGrid G){
    ArrayList<Agent> Lenght = G.getAgents();
    float temp = (float)Lenght.size()/this.CPV;
    temp+=0.5;
    return (int)temp;
  }
  
}
