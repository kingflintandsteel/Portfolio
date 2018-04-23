void setup(){
  size(1000,1000);
  gridSmall.addSugarBlob(40,10,5,4);
  gridSmall.addSugarBlob(15,35,5,4);
  gridLarge.addSugarBlob(40,10,5,4);
  gridLarge.addSugarBlob(15,35,5,4);
  gridExtinct.addSugarBlob(40,10,5,4);
  gridExtinct.addSugarBlob(15,35,5,4);
  gridSmall.setFertility(fSmall);
  gridLarge.setFertility(fLarge);
  fLarge.setType(false);
  fExtinct.setType(false);
  Integer[] agesChildStart = new Integer[]{12,15};
  Integer[] agesYSmallChildStop = new Integer[]{30,40};
  Integer[] agesXSmallChildStop = new Integer[]{40,50};
  Integer[] agesYLargeChildStop = new Integer[]{40,50};
  Integer[] agesXLargeChildStop = new Integer[]{50,60};
  childBearingOnset_Small.put('X',agesChildStart);
  childBearingOnset_Small.put('Y',agesChildStart);
  climatixOnset_Small.put('X',agesYSmallChildStop);
  climatixOnset_Small.put('Y',agesXSmallChildStop);
  childBearingOnset_Large.put('X',agesChildStart);
  childBearingOnset_Large.put('Y',agesChildStart);
  climatixOnset_Large.put('X',agesYLargeChildStop);
  climatixOnset_Large.put('Y',agesXLargeChildStop);
  for(int i = 0; i < 401; i++){
    Agent adding = factory.makeAgent();
    gridSmall.addAgentAtRandom(adding);
    gridLarge.addAgentAtRandom(adding);
    gridExtinct.addAgentAtRandom(adding);
  }
  frameRate(5);
}

HashMap<Character,Integer[]> childBearingOnset_Small = new HashMap();
HashMap<Character,Integer[]> climatixOnset_Small = new HashMap();
HashMap<Character,Integer[]> childBearingOnset_Large = new HashMap();
HashMap<Character,Integer[]> climatixOnset_Large = new HashMap();
HashMap<Character,Integer[]> childBearingOnset_Extinct = new HashMap();
HashMap<Character,Integer[]> climatixOnset_Extinct = new HashMap();

PollutionRule P = new PollutionRule(1,2);
FertilityRule fSmall = new FertilityRule(childBearingOnset_Small,climatixOnset_Small);
FertilityRule fLarge = new FertilityRule(childBearingOnset_Large,climatixOnset_Large);
FertilityRule fExtinct = new FertilityRule(childBearingOnset_Small,climatixOnset_Small);
MovementRule M = new SugarSeekingMovementRule();
MovementRule PM = new PollutionMovementRule();
GrowthRule G = new GrowbackRule(1);
GrowthRule SG = new SeasonalGrowbackRule(2,1,10,20,20);
SugarGrid gridSmall = new SugarGrid(50,50,10,G,P);
SugarGrid gridLarge = new SugarGrid(50,50,10,G,P);
SugarGrid gridExtinct = new SugarGrid(50,50,10,G,P);
LineGraph graph1 = new AgentGraph(550,050,300,100, "Time", "Agents");
LineGraph graph2 = new AgentGraph(550,300,300,100, "Time", "Agents");
LineGraph graph3 = new AgentGraph(550,550,300,100, "Time", "Agents");
AgentFactory factory = new AgentFactory(1,4,1,6,50,100,M);
ReplacementRule R = new ReplacementRule(60,100,factory);

void draw(){
  gridSmall.update();
  fSmall.reproduce(gridSmall);
  gridLarge.update();
  fLarge.reproduce(gridLarge);
  gridExtinct.update();
  fExtinct.reproduce(gridExtinct);
  gridExtinct.display();
  graph1.update(gridSmall);
  graph2.update(gridLarge);
  graph3.update(gridExtinct);
}
