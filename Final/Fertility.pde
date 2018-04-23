class FertilityRule
{
  //variables
  Map<Character, Integer[]> child;
  Map<Character, Integer[]> climax;
  Map<Agent,Integer> referenceChild;
  Map<Agent,Integer> referenceClimax;
  Map<Agent,Integer> PrevSug;
  boolean type;
  
  //constructor
  public FertilityRule(Map<Character, Integer[]> childbearingOnset, Map<Character, Integer[]> climaticOnset){
    this.child = childbearingOnset;
    this.climax = climaticOnset;
    this.PrevSug = new HashMap(30);
    this.referenceChild = new HashMap(30);
    this.referenceClimax = new HashMap(30);
    this.type = true;
  }
  
  //isFertile
  public boolean isFertile(Agent A){
    if(A == null || !A.isAlive()){ //<>//
      //remove A from everything //<>//
      //
      //
      //
      return false; //<>//
    } //<>//
    if(!this.PrevSug.containsKey(A)){ //<>//
      char sex = A.getSex(); //<>//
      if(sex == 'X'){ //<>//
        int cX1 = child.get('X')[0]; //<>//
        int cX2 = child.get('X')[1]; //<>//
        int c = (int)random(cX1,cX2); //<>//
        this.referenceChild.put(A,c); //<>//
        int oX1 = climax.get('X')[0]; //<>//
        int oX2 = climax.get('X')[1]; //<>//
        int o = (int)random(oX1,oX2); //<>//
        this.referenceClimax.put(A,o); //<>//
      } //<>//
      else{ //<>//
        int cY1 = child.get('Y')[0]; //<>//
        int cY2 = child.get('Y')[1]; //<>//
        int c = (int)random(cY1,cY2); //<>//
        this.referenceChild.put(A,c); //<>//
        int oY1 = climax.get('Y')[0]; //<>//
        int oY2 = climax.get('Y')[1]; //<>//
        int o = (int)random(oY1,oY2); //<>//
        this.referenceClimax.put(A,o); //<>//
      } //<>//
    } //<>//
    int C = this.referenceChild.get(A); //<>//
    int O = this.referenceClimax.get(A); //<>//
    int Age = A.getAge(); //<>//
    if(Age >= C && Age < O){ //<>//
      if(!PrevSug.containsKey(A)){ //<>//
        PrevSug.put(A,A.getSugarLevel()); //<>//
      } //<>//
      if(type){
        if(A.getSugarLevel() >= PrevSug.get(A)){  //<>//
          return true; 
        }
      }
      else{
        if(A.getSugarLevel() >= (int)random(10,40)){
          return true;
        }
      }
    } //<>//
    return false; //<>//
  }
  
  //canBreed
  public boolean canBreed(Agent A, Agent B, LinkedList<Square> near){
    for(Square i: near){
      if(i.getAgent() == B) break;
      if(i == near.getLast()) return false;
    }
    for(Square i: near){
      if(i.getAgent() == null) break;
      if(i == near.getLast()) return false;
    }
    if(A.getSex() != B.getSex()) return false;
    else{
      if(isFertile(A) && isFertile(B)) return true;
    }
    return false;
  }
  
  //breed
  public Agent breed(Agent A, Agent B, LinkedList<Square> Alocal, LinkedList<Square> Blocal){
    LinkedList<Square> empty = new LinkedList<Square>();
    Agent NewChild = new Agent(0,0,0,new SugarSeekingMovementRule());
    if(!canBreed(A,B,Alocal) && !canBreed(B,A,Blocal)) return null;
    else{
      int childMeta = 0;
      if((int)random(0,1) == 0) childMeta = A.getMetabolism();
      else childMeta = B.getMetabolism();
      int childVis = 0;
      if((int)random(0,1) == 0) childVis = A.getVision();
      else childVis = B.getVision();
      MovementRule childMove = A.getMovementRule();
      char childSex = 'A';
      if((int)random(0,1) == 0) childSex = 'X';
      else childSex = 'Y';
      NewChild = new Agent(childMeta, childVis, 0, childMove, childSex);
      int halfA = A.getSugarLevel()/2;
      int halfB = B.getSugarLevel()/2;
      A.gift(NewChild,halfA);
      B.gift(NewChild,halfB);
      if((int)random(0,1) == 0){
        for(Square i: Alocal){
          if(i.getAgent() == null) empty.add(i);
        }
      }
      else{
        for(Square i: Blocal){
          if(i.getAgent() == null) empty.add(i);
        }
      }
      Collections.shuffle(empty);
      empty.get((int)random(empty.size())).setAgent(NewChild);
    }
    return NewChild;
  }
  
  //reproduce
  public void reproduce(SugarGrid G){
    ArrayList<Agent> allAgents = G.getAgents();
    for(Agent i: allAgents){
      int k = 0;
      int wide = G.getWidth();
      while(G.getAgentAt(k%wide,k/wide) != i){
        k++;
        if(k > wide*G.getHeight()) break;
      }
      Agent A = i;
      LinkedList<Square> aLocal = G.generateVision(k%wide,k/wide,1);
      aLocal.remove(aLocal.get(0));
      Collections.shuffle(aLocal);
      for(Square j: aLocal){
        Agent B = j.getAgent();
        if(B != null){
          if(this.canBreed(A,B,aLocal)){
            LinkedList<Square> bLocal = G.generateVision(j.getX(),j.getY(),1);
            this.breed(A,B,aLocal,bLocal);
          }
        }
      }
    }
  }
  
  //gets
  ////////////////////////////////////////////
  
  //sets
  ////////////////////////////////////////////
  
  //type
  public void setType(boolean flip){
    this.type = flip;
  }
  
}
