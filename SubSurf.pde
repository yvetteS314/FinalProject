PVector posRun;
PVector posPol;
PVector bgrnd;
PVector duck;
PVector jump;
PVector up;
PVector dir;

PImage bgrd;

boolean start = false;

int speed = 10;
int size = 80;
int w;
int h;
int frameCount = 0;
ArrayList<PVector> runner = new ArrayList<PVector>();
ArrayList<PVector> ducks = new ArrayList<PVector>();
ArrayList<PVector> jumps = new ArrayList<PVector>();
ArrayList<PVector> ups = new ArrayList<PVector>();
ArrayList<String> lane = new ArrayList<String>(); // 1 2 3
ArrayList<String> ob = new ArrayList<String>();

void setup(){
  bgrd = loadImage("SubImage.png");
  frameRate(60);
  fill(77,73,73);
  size(1300, 878);
  w = width / size;
  h = height / size;
  posRun = new PVector (w/4 * size, h/2 * size);
  posPol = new PVector (w/8 * size, h/2 * size);
  newLanes();
  ob.add("duck");
  ob.add("jump");
  ob.add("up");
  newOb();
  }
  
  void newGuy(){
    fill(229,214,162);
    circle(posRun.x, posRun.y, size);
    fill(10,10,10);
    circle(posRun.x + 0.5 * size, posRun.y, 10);
  }

  void newLanes(){
    fill(28,27,27);
    line(0,h/3 * size, w * size + size, h/3 * size);
    line(0, 2*h/3 * size, w * size + size, 2*h/3 * size);
  }
  
  void draw(){
    background(200);
    background(bgrd);
    newLanes();
    newGuy();
    if(frameCount % speed == 0){
    updateOb();
    }
    frameCount ++;
    drawOb();
  }
  
  void newOb(){
    int lowB = 0;
    int upB = 3;
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
    fill (191,132,6);
    square(duck.x, duck.y, h/6 * size);
    }
    for(PVector jump: jumps){
    fill(191,132,6);
    square(jump.x, jump.y, h/6 * size);
    }
    for(PVector up: ups){
    fill(191,132,6);
    triangle(up.x, up.y, up.x, up.y + h/9 * size, up.x - w / 9 * size, up.y + h/9 * size);
    for(int add = 0; add < w * size; add += size){
    square(up.x + add, up.y, size);
    }
    }
  }
  
  void updateOb(){
    if(start == true){
    duck.x -= 0.5 * size;
    jump.x -= 0.5 * size;
    up.x -= 0.5 * size;
   ducks.add(duck);
        if(ducks.size() > 1){
        ducks.remove(0);
        }
  jumps.add(jump);
        if(jumps.size() > 1){
          jumps.remove(0);
        }
  ups.add(up);
        if(ups.size() > 1){
          ups.remove(0);
      }
    }
    if(duck.x < 0){
      ob.add("duck");
      ob.add("jump");
      ob.add("up");
      newOb();
    }
  }
  
  void updateGuy(){
    runner.add(posRun);
    if(runner.size() > 0 ){
      runner.remove(0);
    }
    
    for(PVector posRun : runner){
      if(posRun.x == duck.x && posRun.y == duck.y|| posRun.x == jump.x && posRun.y == jump.y){
        reset();
    }
  }
  }
  void keyPressed(){
    if(key == CODED){
      if(keyCode == RIGHT){
       start = true;
      }
      if(keyCode == UP){
        posRun.set(new PVector(posRun.x, posRun.y - size));
      }
      if(keyCode == DOWN){
        posRun.set(new PVector(posRun.x, posRun.y + size));
      }
    }
  }

  
  void reset(){
    
  } 
