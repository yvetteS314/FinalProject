PVector posRun;
PVector posPol;
PVector bgrnd;
PVector duck;
PVector jump;
PVector up;

int speed = 20;
int size = 40;
int w;
int h;
ArrayList<PVector> lane = new ArrayList<PVector>(); // 1 2 3
ArrayList<PVector> ob = new ArrayList<PVector>();

void setup(){
  frameRate(60);
  fill(77,73,73);
  size(1080, 720);
  ob.add(duck);
  ob.add(jump);
  ob.add(up);
  
  w = width / size;
  h = height / size;
  posRun = new PVector (w/4, h/2);
  posPol = new PVector (w/8, h/2);
  newLanes();
  newOb();
  }
  
  void newGuy(){
    fill(229,214,162);
    circle(posRun.x, posRun.y, size);
  }
  void newLanes(){
    fill(28,27,27);
    line(0,h/3 * size, w * size, h/3 * size);
    line(0, 2*h/3 * size, w * size, 2*h/3 * size);
  }
  
  void draw(){
  }
  void newOb(){
    int lowB = 0;
    int upB = 2;
    for(int inLane = 0; inLane < 3; inLane ++){
      int inOb = (int) random (lowB, upB);
      lane.add(ob.get(inOb));
      ob.remove(inOb);
      upB --;
    }
    
    for(int inLane = 0; inLane < 3; inLane ++){
      if(inLane == 0){
      if(lane.get(inLane) == duck){
        duck = new PVector(w * size - size * h/6, inLane * h/3 * size);
        fill (57,49,17);
        square(duck.x, duck.y, h/6 * size);
      }
      if(lane.get(inLane) == jump){
        jump = new PVector(w * size - size * h/6, inLane * 2*h/3 * size);
        fill(60,49,17);
        square(jump.x, jump.y, h/6 * size);
      }
      else{
        up = new PVector(w * size - size * h/6, inLane * 2*h/3 * size);
        fill(70,49,17);
        square(up.x,up.y, h/6 * size);
      }
    }
    if(inLane == 1){
    }
    }
    
  }
  
  void keyPressed(){
  }
  
  void reset(){
  } 
