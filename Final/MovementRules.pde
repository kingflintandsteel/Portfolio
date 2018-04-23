import java.util.*;

interface MovementRule
{
  //move
  public Square move(LinkedList<Square> near, SugarGrid G, Square Middle);
  
}

public class SugarSeekingMovementRule implements MovementRule
{
  //variables
  
  //constructor
  public SugarSeekingMovementRule(){}
  
  //move
  public Square move(LinkedList<Square> near, SugarGrid G, Square Middle){
    Collections.shuffle(near);
    Square BestS = new Square(0,0,0,0);
    int BestI = 0;
    for(Square i: near){
      if(i.getSugar() > BestI){ BestS = i; BestI = i.getSugar(); }
      else if(i.getSugar() == BestI){
        if(BestI == 0);
        else{
          if(G.euclidianDistance(i,Middle) < G.euclidianDistance(BestS, Middle)){ 
            if(i.getAgent() == null){
              BestS = i; 
            }
          }
        }
      }
    }
    return BestS;
  }
  
}

public class PollutionMovementRule implements MovementRule
{
  //variables
  
  //constructor
  public PollutionMovementRule(){}
  
  //move
  public Square move(LinkedList<Square> near, SugarGrid G, Square Middle){
    Square BestS = new Square(0,0,0,0);
    int BestP = 10000;
    int BestI = 1;
    for(Square i: near){
      int ratio = i.getPollution()/i.getSugar();
      if(ratio < BestP/BestI){ BestS = i; BestI = i.getSugar(); BestP = i.getPollution(); }
      else if(ratio == BestP/BestI){
        if(G.euclidianDistance(i,Middle) < G.euclidianDistance(BestS, Middle)){ 
          if(i.getAgent() == null){
            BestS = i; 
            BestP = i.getPollution(); 
            BestI = i.getSugar(); 
          }
        }
      }
    }
    return BestS;
  }
}
