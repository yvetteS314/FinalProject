PVector posRun;
PVector posPol;
PVector bgrnd;
PVector duck;
PVector jump;
PVector up;


int speed = 20;
int size = 80;
int w;
int h;
ArrayList<PVector> ducks = new ArrayList<PVector>();
ArrayList<PVector> jumps = new ArrayList<PVector>();
ArrayList<PVector> ups = new ArrayList<PVector>();
ArrayList<String> lane = new ArrayList<String>(); // 1 2 3
ArrayList<String> ob = new ArrayList<String>();

void setup(){
  frameRate(60);
  fill(77,73,73);
  size(1080, 720);
  w = width / size;
  h = height / size;
  posRun = new PVector (w/4, h/2);
  posPol = new PVector (w/8, h/2);
  newLanes();
  ob.add("duck");
  ob.add("jump");
  ob.add("up");
  newOb();
  }
  
  void newGuy(){
    fill(229,214,162);
    circle(posRun.x, posRun.y, size);
  }
  void newLanes(){
    fill(28,27,27);
    line(0,h/3 * size, w * size + size, h/3 * size);
    line(0, 2*h/3 * size, w * size + size, 2*h/3 * size);
  }
  
  void draw(){
    drawOb();
  }
  
  void newOb(){
    int lowB = 0;
    int upB = 2;
    for(int inLane = 0; inLane < 3; inLane ++){
      int inOb = (int) random (lowB, upB);
     // println(ob);
      lane.add(ob.get(inOb));
      //println(lane);
      ob.remove(inOb);
      upB --;
    }
 
    for(int inLane = 0; inLane < 3; inLane ++){
      if(inLane == 0){
      if(lane.get(inLane) == "duck"){
        duck = new PVector(w * size - size / 2, inLane * h/3 * size);
        ducks.add(duck);
        println("duck");
      }
      else{
        if(lane.get(inLane) == "jump"){
        jump = new PVector(w * size - size / 2, (inLane + 1) * h / 3 * size - h / 9 * size);
        jumps.add(jump);
        println("jump");
      }
      else{
        up = new PVector(w * size + size /2 , (inLane + 1) * h / 3 * size - h / 9 * size);
        println("up");
      }
    }
      }
    else{
      if(inLane == 1){
      if(lane.get(inLane) == "duck"){
        duck = new PVector(w * size - size / 2, inLane * h/3 * size);
        ducks.add(duck);
        println("duck");
      }
      else{
        if (lane.get(inLane) == "jump"){
        jump = new PVector(w * size - size / 2, (inLane + 1) * h / 3 * size - h / 9 * size);
        jumps.add(jump);
        println("jump");
    }
    else{
      up = new PVector(w * size + size /2 , (inLane + 1) * h / 3 * size - h / 9 * size);
      ups.add(up);  
        println("up");
    }
    }
    }
    else{
      if(lane.get(inLane) == "duck"){
        duck = new PVector(w * size - size / 2, inLane * h/3 * size);
        ducks.add(duck);
        println("duck");
      }
      else{
        if (lane.get(inLane) == "jump"){
        jump = new PVector(w * size - size / 2, (inLane + 1) * h / 3 * size - h / 9 * size);
        jumps.add(jump);
        println("jump");
    }
    else{
      up = new PVector(w * size + size /2 , (inLane + 1) * h / 3 * size - h / 9 * size);
        ups.add(up);  
        println("up");
    }
    }
    }
  }
    }
  }
 
  
  
  void drawOb(){
    for(PVector duck: ducks){
    fill (57,49,17);
    square(duck.x, duck.y, h/6 * size);
    }
    for(PVector jump: jumps){
    fill(60,49,17);
    square(jump.x, jump.y, h/6 * size);
    }
    for(PVector up: ups){
    fill(70,49,17);
    triangle(up.x, up.y, up.x, up.y + h/9 * size, up.x - w / 9 * size, up.y + h/9 * size);
    square(up.x + size, up.y, size);
    }
  }
  
  void updateOb(){
   //duck.set(new PVector(- 1, 0));
  // drawOb(); 
  }
  
  void keyPressed(){
    if(key == CODED){
      if(keyCode == RIGHT){
        duck = new PVector(duck.x - size, duck.y);
        ducks.add(duck);
        if(ducks.size() > 1){
        ducks.remove(0);
        }
        jump = new PVector(jump.x - size, jump.y);
        jumps.add(jump);
        if(jumps.size() > 1){
          jumps.remove(0);
        }
        up = new PVector(up.x - size, up.y);
        ups.add(up);
        if(ups.size() > 1){
          ups.remove(0);
      }
      }
    }
  }

  
  void reset(){
    setup();
  } 
