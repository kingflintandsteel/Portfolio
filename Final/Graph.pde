class Graph
{
  //variables
  int x;
  int y;
  int Width;
  int Height;
  String xlab;
  String ylab;
  int counter;
  
  //constructor
  public Graph(int x, int y, int Width, int Height, String xlab, String ylab){
    this.x = x;
    this.y = y;
    this.Width = Width;
    this.Height = Height;
    this.xlab = xlab;
    this.ylab = ylab;
    this.counter = 0;
  }
  
  //update
  public void update(SugarGrid G){
    fill(255);
    strokeWeight(1);
    stroke(255);
    rect(this.x,this.y,this.Width,this.Height);
    stroke(0);
    line(this.x,this.y+this.Height,this.x+this.Width,this.y+this.Height);
    line(this.x,this.y,this.x,this.y+this.Height);
    textAlign(CENTER);
    fill(0);
    text(this.xlab, this.x+this.Width,this.y+this.Height+12);
    pushMatrix();
    translate(this.x,this.y);
    rotate(-PI/2.0);
    text(this.ylab, 0, -5);
    popMatrix();
  }
  
}


abstract class LineGraph extends Graph
{
  //variables
  int X;
  int Y;
  int HW;
  int HT;
  String Xlab;
  String Ylab;
  int UpdateCount;
  int counter;
  
  //constructor
  public LineGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.X = X;
    this.Y = Y;
    this.HW = HowWide;
    this.HT = HowTall;
    this.Xlab = Xlab;
    this.Ylab = Ylab;
    this.UpdateCount = 0;
    this.counter = 0;
  }
  
  //nextPoint
  public abstract int nextPoint(SugarGrid G);
  
  //update
  public void update(SugarGrid G){
    counter++;
    strokeWeight(1);
    if(UpdateCount == 0){
      super.update(G);
      this.UpdateCount++;
    }
    else if(counter%2 ==0){
      stroke(0);
      point(this.UpdateCount+this.X,this.Y+this.HT-(nextPoint(G))/4);
      this.UpdateCount++;
      if(this.UpdateCount > this.HW){
        this.UpdateCount = 0;
      }
    }
  }
  
}

class SugarGraph extends LineGraph
{
  //variables
  int AS;
  int X;
  int Y;
  int HW;
  int HT;
  
  //constructor
  public SugarGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.HT = HowTall;
  }
  
  //nextPoint
  public int nextPoint(SugarGrid G){
    int TotalAgents = G.getAgents().size();
    if(TotalAgents == 0){
      return this.X;
    }
    int TotalSugar = 0;
    for(Agent i: G.getAgents()){
      TotalSugar += i.getSugarLevel();
    }
    int temp = TotalSugar/TotalAgents;
    temp /= (this.HT/4);
    return temp+5;
  }
  
}

class MetabolismGraph extends LineGraph
{
  //variables
  int AS;
  int X;
  int Y;
  int HW;
  int HT;
  
  //constructor
  public MetabolismGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.HT = HowTall;
  }
  
  //nextPoint
  public int nextPoint(SugarGrid G){
    int TotalAgents = G.getAgents().size();
    if(TotalAgents == 0) return X;
    int TotalMetabolism = 0;
    for(Agent i: G.getAgents()){
      TotalMetabolism += i.getMetabolism();
    }
    int temp = TotalMetabolism/TotalAgents;
    temp /= this.HT;
    return temp+5;
  }
  
}

class VisionGraph extends LineGraph
{
  //variables
  int AS;
  int X;
  int Y;
  int HW;
  int HT;
  
  //constructor
  public VisionGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.HT = HowTall;
  }
  
  //nextPoint
  public int nextPoint(SugarGrid G){
    int TotalAgents = G.getAgents().size();
    if(TotalAgents == 0) return X;
    int TotalVision = 0;
    for(Agent i: G.getAgents()){
      TotalVision += i.getVision();
    }
    int temp = TotalVision/TotalAgents;
    temp /= this.HT;
    return temp+5;
  }
  
}

class AgentGraph extends LineGraph
{
  //variables
  int x;
  int y;
  int HW;
  int HT;
  
  //constructor
  public AgentGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.HT = HowTall;
  }
  
  //nextPoint
  public int nextPoint(SugarGrid G){
    int temp =  G.getAgents().size();
    println(temp);
    if(temp == 0) return this.X;
    temp /= (this.HT/15);
    return temp+5;
  }
  
}

class FertilityGraph extends LineGraph
{
  //variables
  int x;
  int y;
  int HW;
  int HT;
  FertilityRule F;
  
  //constructor
  public FertilityGraph(int X, int Y, int HowWide, int HowTall, String Xlab, String Ylab, FertilityRule F){
    super(X,Y,HowWide,HowTall,Xlab,Ylab);
    this.F = F;
  }
  
  //nextPoint
  public int nextPoint(SugarGrid G){
    int totalAgents = G.getAgents().size();
    int totalFertility = 0;
    if(totalAgents == 0) return this.X;
    for(Agent i: G.getAgents()){
      if(this.F.isFertile(i)){
        totalFertility++;
      }
    }
    return totalFertility/totalAgents;
  }
  
}
