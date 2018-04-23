abstract class Sorter
{
  //sort
  public abstract void sort(ArrayList<Agent> al);
  
  //lessThan
  public boolean lessThan(Agent A, Agent B){
    if(A.getSugarLevel() < B.getSugarLevel()) return true;
    else return false;
  }
  
}

class BubbleSorter extends Sorter
{
  //variables
  boolean done;
  boolean swapped;
  
  //constructor
  public BubbleSorter(){
    this.done = false;
    this.swapped = false;
  }
  
  //sort
  public void sort(ArrayList<Agent> al){
    done = false;
    swapped = false;
    int size = al.size();
    while(!done){
      for(int i = 0; i < size; i++){
        if(lessThan(al.get(i-1),al.get(i))){
          Agent temp = al.get(i);
          al.set(i,al.get(i-1));
          al.set(i-1,temp);
          swapped = true;
        }
        if(swapped == false) done = true;
      }
    }
  }
  
}

class InsertionSorter extends Sorter
{
  //variables
  
  //constructor
  public InsertionSorter(){}
  
  //sort
  public void sort(ArrayList<Agent> al){
    int size = al.size();
    for(int i = 0; i < size; i++){
      Agent temp = al.get(i);
      int j = i-1;
      while(j >= 0 && lessThan(temp,al.get(j))){
        al.set(j+1,al.get(j));
        j--;
      }
      al.set(j+1,temp);
    }
  }
  
}

class MergeSorter extends Sorter
{
  //variables
  ArrayList<Agent> AUX;
  
  //constructor
  public MergeSorter(){}
  
  //sort
  public void sort(ArrayList<Agent> al){
    AUX = new ArrayList<Agent>(al);
    sort(al,0,al.size());
  }
  
  //sort(private)
  private void sort(ArrayList<Agent> al, int start, int end){
    if(end - start == 1) return;
    
    int middle = (end+start)/2;
    sort(al,start,middle);
    sort(al,middle,end);
    merge(al,start,end);
  }
  
  //merge(private)
  private void merge(ArrayList<Agent> al, int start, int end){
    for(int i = start; i < end; i++){
      AUX.set(i,al.get(i));
    }
    int middle = (start+end)/2;
    int current = start;
    int i = start;
    int j = middle;
    while(i < middle && j < end){
      if(lessThan(AUX.get(j),AUX.get(i))) al.set(current++, AUX.get(j++));
      else al.set(current++,AUX.get(i++));
    }
    if(i == middle){
      while(j < end) al.set(current++, AUX.get(j++));
    }
    if(j == end){
      while(i < middle) al.set(current++, AUX.get(i++));
    }
  }
  
}

class QuickSorter extends Sorter
{
  //variables
  
  //constructor
  public QuickSorter(){}
  
  //sort
  public void sort(ArrayList<Agent> al){
    Collections.shuffle(al);
    sort(al,0,al.size()-1);
  }
  
  //sort(private)
  private void sort(ArrayList<Agent> al, int start, int end){
    if(end <= start) return;
    int pivot = partition(al,start,end);
    sort(al,start,pivot-1);
    sort(al,pivot+1,end);
  }
  
  //partition(private)
  private int partition(ArrayList<Agent> al, int start, int end){
    int i = start;
    int j = end;
    while(true){
      while(lessThan(al.get(++i), al.get(start))){
        if(i == end) break;
      }
      while(lessThan(al.get(start), al.get(--j))){
        if(j == start) break;  
      }
      
      if(i >= j) break;
      exchange(al,i,j);
    }
    exchange(al,start,j);
    return j;
  }
  
  //exchange(private)
  private void exchange(ArrayList<Agent> al, int i, int j){
    Agent temp = al.get(i);
    al.set(i, al.get(j));
    al.set(j,temp);
  }
  
}
