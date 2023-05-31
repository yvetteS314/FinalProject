PVector posRun;
PVector posPol;
PVector bgrnd;
PVector duck;
PVector jump;
PVector up;
PVector coin;
PVector bodyPart;
PVector arms;
PVector legs;


PImage bgrd;

boolean start = false;

int speed = 10;
int size = 80;
int w;
int h;
int frameCount = 0;
int  savedTime;
int totTime = 1000;
int currentScore;
int highScore;

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
  savedTime = millis();
  w = width / size;
  h = height / size;
  currentScore = 0;
  posRun = new PVector (w/4 * size, h/2 * size);
  posPol = new PVector (w/8 * size, h/2 * size);
  newLanes();
  ob.add("duck");
  ob.add("jump");
  ob.add("up");
  newOb();
  newCoin();
  }
  
  void gravity(){
    if(posRun.y < h/3 * size - size){
      int curY = (int) posRun.y;
      if(curY < h/3 * size){
        posRun.y ++; 
        curY = (int) posRun.y;
      }
      }
      
    if(posRun.y < 2*h/3 * size - size && posRun.y > h/3 * size - size){
        int curY = (int) posRun.y;
        if(curY < 2 * h/3 * size){
        posRun.y ++;
        curY = (int) posRun.y;
        }
      }
      if(posRun.y < h * size - 2 * size && posRun.y > 2*h/3 * size - size){
        int curY = (int) posRun.y;
      if(curY < h * size){
        posRun.y ++;
        curY = (int) posRun.y;
      }
      }
  }
  
  void newCoin(){
    int pos = (int) random(0, 2);
    if(lane.get(pos) == "jump"){
      coin = new PVector(jump.x - size, jump.y + 0.75 * size);
    }
    if(lane.get(pos) == "up"){
      coin = new PVector(up.x + size, up.y - 0.25 * size);
    }
    if(lane.get(pos) == "duck"){
      coin = new PVector(duck.x, duck.y + 2.75 * size);
    }
  }
  
  void drawCoin(){
    fill(224,210,77);
    circle(coin.x, coin.y, size / 2);
    circle(coin.x + size, coin.y, size / 2);
    circle(coin.x + 2 * size, coin.y, size / 2);
  }
  
  void newGuy(){
    fill(229,214,162);
    circle(posRun.x, posRun.y, size);
    fill(10,10,10);
    circle(posRun.x + 0.5 * size, posRun.y, 10);
    bodyPart = new PVector(posRun.x - 0.35 * size, posRun.y + 0.5 * size);
    fill(72, 10, 95);
    square(bodyPart.x, bodyPart.y, size * 3 / 4);
    circle(bodyPart.x, bodyPart.y, size * 1/4);
    circle(bodyPart.x + size * 0.75, bodyPart.y, size * 1/4);
    rect(bodyPart.x, bodyPart.y + size * 0.75, size * 1/4, size * 3/8);
    rect(bodyPart.x + size * 0.5, bodyPart.y + size * 0.75, size * 1/4, size * 3/8);
    rect(bodyPart.x - size * 0.125, bodyPart.y, size * 0.125, size * 0.5);
    rect(bodyPart.x + size * 0.75, bodyPart.y, size * 0.125, size * 0.5);
    runner.add(bodyPart);
  }
  
  void moveLimbs(){
    arms = new PVector(bodyPart.x - size * 0.125, bodyPart.y + size * 0.5);
    legs = new PVector(bodyPart.x, bodyPart.y + size * 9/8);
    runner.add(arms);
    runner.add(legs);
    if(start == false){
    rect(arms.x, arms.y, size * 0.125, size * 0.5);
    rect(arms.x + size * 0.875, arms.y, size * 0.125, size * 0.5);
    rect(legs.x, legs.y, size * 1/4, size * 3/8);
    rect(legs.x + size * 0.5,legs.y, size * 1/4, size * 3/8);
    }
    if(start == true){
    if (second() % 2 == 0){
      rect(arms.x, arms.y, size * 0.125, size * 0.5);
      rect(arms.x + size * 0.875, arms.y, size * 0.5, size * 0.125);
      rect(legs.x - size * 3/8 + size * 1/4, legs.y, size * 3/8, size * 1/4);
      rect(legs.x + size * 0.5,legs.y, size * 1/4, size * 3/8);
      //savedTime = millis();
    }
    else{
      rect(arms.x, arms.y, size * 0.5, size * 0.125);
      rect(arms.x + size * 0.875, arms.y, size * 0.125, size * 0.5);
      rect(legs.x, legs.y, size * 1/4, size * 3/8);
      rect(legs.x + size * 0.5 - size * 3/8 + size * 1/4,legs.y, size * 3/8, size * 1/4);
    }
    }
  }
  
  void newLanes(){
    fill(28,27,27);
    for(int track = 0; track < w * size; track += size){
      line(track, h/3 * size, track, h/3 * size + h/6 * size);
    }
    line(0, h/3 * size + h/6 * size, w * size + size, h/3 * size + h/6 * size);
    line(0,h/3 * size, w * size + size, h/3 * size);
    for(int track = 0; track < w * size; track += size){
      line(track, 2*h/3 * size, track, 2*h/3 * size + h/6 * size);
    }
    line(0, 2*h/3 * size + h/6 * size, w * size + size, 2*h/3 * size + h/6 * size);
    line(0, 2*h/3 * size, w * size + size, 2*h/3 * size);
    for(int track = 0; track < w * size; track += size){
      line(track, h * size, track, h * size - size);
    }
    line(0, h * size - size, w * size, h * size - size);
    line(0, h * size, w * size, h * size);
  }
  
  void draw(){
    background(200);
    background(bgrd);
    newGuy();
    moveLimbs();
    newLanes();
    if(frameCount % speed == 0){
    if (duck.x < - size){
       newOb();
    }
    updateOb();
    }
    frameCount ++;
    drawOb();
    gravity();
    drawCoin();
    updateGuy();
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
        duck = new PVector(w * size - size / 2, inLane * h/3 * size + size);
        ducks.add(duck);
        println("duck");
      }
      else{
        if(lane.get(inLane) == "jump"){
        jump = new PVector(w * size - size / 2, (inLane + 1) * h / 3 * size - h / 9 * size + size);
        jumps.add(jump);
        println("jump");
      }
      else{
        up = new PVector(w * size + size /2 , (inLane + 1) * h / 3 * size - h / 9 * size + size);
        println("up");
      }
    }
      }
    else{
      if(inLane == 1){
      if(lane.get(inLane) == "duck"){
        duck = new PVector(w * size - size / 2, inLane * h/3 * size + size);
        ducks.add(duck);
        println("duck");
      }
      else{
        if (lane.get(inLane) == "jump"){
        jump = new PVector(w * size - size / 2, (inLane + 1) * h / 3 * size - h / 9 * size + size);
        jumps.add(jump);
        println("jump");
    }
    else{
      up = new PVector(w * size + size /2 , (inLane + 1) * h / 3 * size - h / 9 * size + size);
      ups.add(up);  
        println("up");
    }
    }
    }
    else{
      if(lane.get(inLane) == "duck"){
        duck = new PVector(w * size - size / 2, inLane * h/3 * size + size);
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
    coin.x -= 0.5 * size;
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
    if(duck.x < - size){
      int size = lane.size();
      for(int i = 0; i < size; i ++){
        lane.remove(0);
      }
      ob.add("duck");
      ob.add("jump");
      ob.add("up");
      ducks.remove(0);
      jumps.remove(0);
      ups.remove(0);
    }
  }
  
  void updateGuy(){
    runner.add(posRun);
    runner.add(bodyPart);
    if(runner.size() > 0 ){
      runner.remove(0);
    }
    int lanes = -1;
      if(legs. y< h/3 * size + size){
        lanes = 0;
      }
      if(legs.y > h/3 * size + size && legs.y < 2*h/3 * size + size){
        lanes = 1;
      }
      if(legs.y > 2*h/3 * size + size){
        lanes = 2;
      }
      if(lane.get(lanes) == "duck"){
      }
      if(lane.get(lanes) ==  "jump"){
      }
      if(lane.get(lanes) == "up"){
      }
     
  }

  void keyPressed(){
    if(key == CODED){
      if(keyCode == RIGHT){
       start = true;
      }
      if(keyCode == UP){
        if(posRun.y > 0){
        posRun.set(new PVector(posRun.x, posRun.y - 3/2 * size));
        }
      }
      if(keyCode == DOWN){
        if(posRun.y < h * size - 2 * size){
        posRun.set(new PVector(posRun.x, posRun.y + 3/2 * size));
      }
      }
    }
  }
  
  void reset(){
    background(200);
    background(bgrd);
    frameRate(60);
  fill(77,73,73);
  size(1300, 878);
  savedTime = millis();
  w = width / size;
  h = height / size;
  posRun = new PVector (w/4 * size, h/2 * size);
  posPol = new PVector (w/8 * size, h/2 * size);
  newLanes();
  ob.add("duck");
  ob.add("jump");
  ob.add("up");
  newOb();
  start = false;
  } 
