class SugarGrid
{
  //variables
  int Width;
  int Height;
  int sidelength;
  GrowthRule G;
  ArrayList Grid;
  PollutionRule P;
  FertilityRule F;
  ReplacementRule R;
  
  //constructor
  public SugarGrid(int Width, int Height, int sidelength, GrowthRule G, PollutionRule P){
    this.Width = Width;
    this.Height = Height;
    this.sidelength = sidelength;
    this.G = G;
    this.P = P;
    this.Grid = new ArrayList<ArrayList<Square>>(this.Width);
    for(int i = 0; i < this.Width; i++){
      ArrayList<Square> temp = new ArrayList<Square>(this.Height);
      for(int j = 0; j < this.Height; j++){
        Square test = new Square(0,0,i,j);
        temp.add(test);
      }
      this.Grid.add(temp);
    }
  }
  
  //euclidianDistance
  public double euclidianDistance(Square A, Square B){
    return sqrt(sq(min(abs(A.getX() - B.getX()), this.Width - abs(A.getX() - B.getX()))) + sq(min(abs(A.getY() - B.getY()), this.Height - abs(A.getY() - B.getY()))));
  }
  
  //generateVision
  public LinkedList<Square> generateVision(int x, int y, int radius){
    LinkedList<Square> temp = new LinkedList<Square>();
    for(int i = -radius; i <= radius; i++){
      if(i==0);
      else temp.add(getSquare(x+i,y));
    }
    for(int i = -radius; i <= radius; i++){
      if(i==0) temp.addFirst(getSquare(x,y+i));
      else temp.add(getSquare(x,y+i));
    }
    return temp;
  }
  
  //addSugarBlob
  public void addSugarBlob(int x, int y, int radius, int maxsugarlevel){
    Square mid = getSquare(x,y);
    for(int i = 0; i < this.Width; i++){
      for(int j = 0; j < this.Height; j++){
        Square temp = getSquare(i,j);
        int subtractor = (int)euclidianDistance(mid,temp)/radius;
        if(temp.getMaxSugar() < maxsugarlevel-subtractor){
          temp.setMaxSugar(maxsugarlevel-subtractor);
          temp.setSugar(temp.getMaxSugar());
        }
      }
    }
  }
  
  //placeAgent
  public void placeAgent(Agent A, int row, int column){
    getSquare(row,column).setAgent(A);
  }
  
  //update
  public void update(){
    MovementRule m = new SugarSeekingMovementRule();
    Agent testing = new Agent(0,0,0,m);
    for(int i = 0; i < this.Width; i++){
      for(int j = 0; j < this.Height; j++){
        Square temp = getSquare(i,j);
        Agent temper = temp.getAgent();
        this.G.growBack(temp);
        if(temper == null);
        else{
          if(temper == testing);
          else{
            testing = temper;
            LinkedList<Square> vision = generateVision(i,j,testing.getVision());
            Square mid = vision.get(0);
            Collections.shuffle(vision);
            Square destination = temper.getMovementRule().move(vision,this,mid);
            testing.move(temp,destination);
            testing.step();
            if(testing.isAlive()) testing.eat(temp);
            else destination.setAgent(null);
          }
        }
      }
    }
  }
  
  //display
  public void display(){
    for(int i = 0; i < this.Width; i++){
      for(int j = 0; j < this.Height; j++){
        getSquare(i,j).display(this.sidelength);
      }
    }
  }
  
  //addAgentAtRandom
  public void addAgentAtRandom(Agent A){
    int x = abs((int)random(this.Width));
    int y = abs((int)random(this.Height));
    while(getAgentAt(x,y) != null){
      x = abs((int)random(this.Width));
      y = abs((int)random(this.Height));
    }
    placeAgent(A,x,y);
  } //<>//
  
  //gets
  ///////////////////////////////////////////////
  
  //getSquare
  public Square getSquare(int x, int y){
    ArrayList<Square> temp = (ArrayList)this.Grid.get(0);
    if(x >= this.Width){
      temp = (ArrayList)this.Grid.get(x-this.Width);
    }
    else if(x < 0){
      temp = (ArrayList)this.Grid.get(x+this.Width);
    }
    else{
      temp = (ArrayList)this.Grid.get(x);
    }
    Square tempS = temp.get(0);
    if(y >= this.Height){
      tempS = temp.get(y-this.Height);
    }
    else if(y < 0){
      tempS = temp.get(y+this.Height);
    }
    else{
      tempS = temp.get(y);
    }
    return tempS;
  }
  
  //getWidth
  public int getWidth(){
    return this.Width;
  }
  
  //getHeight
  public int getHeight(){
    return this.Height;
  }
  
  //getSquareSize
  public int getSquareSize(){
    return this.sidelength;
  }
  
  //getSugarAt
  public int getSugarAt(int x, int y){
    return getSquare(x,y).getSugar();
  }
  
  //getMaxSugarAt
  public int getMaxSugarAt(int x, int y){
    return getSquare(x,y).getMaxSugar();
  }
  
  //getAgentAt
  public Agent getAgentAt(int x, int y){
    return getSquare(x,y).getAgent();
  }
  
  //getAgents
  public ArrayList<Agent> getAgents(){
    ArrayList<Agent> temp = new ArrayList<Agent>();
    for(int i = 0; i < this.Width; i++){
      for(int j = 0; j < this.Height; j++){
        Agent here = this.getSquare(i,j).getAgent();
        if(here != null) temp.add(here);
      }
    }
    return temp;
  }
  
  //sets
  //////////////////////////////////////////////////////
  
  //fertility
  public void setFertility(FertilityRule F){
    this.F = F;
  }
  
  //replacement
  public void setReplacement(ReplacementRule R){
    this.R = R;
  }
  
}
