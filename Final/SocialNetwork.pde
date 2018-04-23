class SocialNetwork
{
  //variables
  private LinkedList<SocialNetworkNode>[] adj;
  int size;
  SugarGrid G;
  
  //constructor
  public SocialNetwork(SugarGrid G){
    this.size = G.getWidth()*G.getHeight();
    adj = new LinkedList[this.size];
    for(int i = 0; i < G.getWidth(); i++){
      LinkedList<SocialNetworkNode> temp = new LinkedList<SocialNetworkNode>();
      for(int j = 0; j < G.getHeight(); j++){
        Agent here = G.getAgentAt(i,j);
        if(here == null);
        else{
          int radius = here.getVision();
          LinkedList<Square> vision = G.generateVision(i,j,radius);
          for(Square S: vision){
            Agent inVision = S.getAgent();
            if(inVision == null);
            else{
              temp.add(new SocialNetworkNode(inVision));
            }
          }
          int index = i + (j*G.getHeight());
          adj[index] = temp;
        }
      }
    }
    this.G = G;
  }
  
  //adjacent
  public boolean adjacent(SocialNetworkNode A, SocialNetworkNode B){
    int i = 0;
    while(i <= this.size && !(this.adj[i].get(0) == A)){
      i++;
    }
    if(i > this.size) return false;
    LinkedList<SocialNetworkNode> temp = this.adj[i];
    if(temp.contains(B)) return true;
    else{
      i = 0;
      while(i <= this.size && !(this.adj[i].get(0) == B)){
        i++;
      }
      if(i > this.size) return false;
      LinkedList<SocialNetworkNode> temp2 = this.adj[i];
      if(temp2.contains(A)) return true;
    }
    return false;
  }
  
  //seenBy
  public LinkedList<SocialNetworkNode> seenBy(SocialNetworkNode A){
    LinkedList<SocialNetworkNode> temp = new LinkedList<SocialNetworkNode>();
    for(LinkedList i: adj){
      if(i.get(0) != A && i.contains(A)){
        temp.add((SocialNetworkNode)i.get(0));
      }
      if(temp.isEmpty()) return null;
    }
    return temp;
  }
  
  //sees
  public LinkedList<SocialNetworkNode> sees(SocialNetworkNode B){
    for(LinkedList i: adj){
      if(i.get(0) == B) return i;
    }
    return null;
  }
  
  //resetPaint
  public void resetPaint(){
    for(LinkedList<SocialNetworkNode> i: adj){
      for(SocialNetworkNode j: i){
        j.unpaint();
      }
    }
  }
  
  //pathExsists
  public boolean pathExsists(Agent A, Agent B){
    SocialNetworkNode a = getNode(A);
    SocialNetworkNode b = getNode(B);
    if(adjacent(a,b)) return true;
    else{
      LinkedList<SocialNetworkNode> temp = sees(a);
      for(SocialNetworkNode i: temp){
        if(!i.painted()){
          i.paint();
          if(pathExsists(i.getAgent(),B)) return true;
        }
      }
    }
    resetPaint();
    return false;
  }
  
  //bacon
  public LinkedList<SocialNetworkNode> bacon(Agent A, Agent B){
    if(!pathExsists(A,B)) return null;
    SocialNetworkNode a = getNode(A);
    SocialNetworkNode b = getNode(B);
    LinkedList<SocialNetworkNode> path = new LinkedList<SocialNetworkNode>();
    LinkedList<SocialNetworkNode> shortest = new LinkedList<SocialNetworkNode>();
    if(adjacent(a,b)){
      path.add(a);
      path.add(b);
      return path;
    }
    else{
      int Length = 1000;
      int i = 0;
      for(LinkedList j: adj){
        if(j.get(0) == a) break;
        else i++;
      }
      for(SocialNetworkNode j : adj[i]){
        if(!j.painted()){
          j.paint();
          LinkedList<SocialNetworkNode> temp = bacon(j.getAgent(),B);
          if(temp.size() < Length){ 
            Length = temp.size(); 
            shortest = temp;
          }
        }
      }
      shortest.addFirst(a);
      return shortest;
    }
  }
  
  //gets
  ////////////////////////////////////////////
  
  //getNode
  public SocialNetworkNode getNode(Agent A){
    for(LinkedList<SocialNetworkNode> i: adj){
      for(SocialNetworkNode j : i){
        if(j.getAgent() == A) return j;
      }
    }
    return null;
  }
  
}
