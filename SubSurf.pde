import processing.sound.*;
SoundFile file;

PVector posRun;
PVector posPol;
PVector bgrnd;
PVector duck;
PVector jump;
PVector up;
PVector coin;
PVector bodyPart;
PVector bodyPol;
PVector arms;
PVector legs;
PVector aPol;
PVector lPol;
PVector board;

PImage bgrd;

boolean start = false;
boolean squat = false;
boolean boardTouch = false;

int speed = 10;
int size = 80;
int w;
int h;
int pos;
int lanes;
int frameCount = 0;
int  savedTime;
int totTime = 1000;
int currentScore;
int highScore;
int squatStart;
int newPos;
int increment = 0;
int boardTime;

ArrayList<PVector> runner = new ArrayList<PVector>();
ArrayList<PVector> ducks = new ArrayList<PVector>();
ArrayList<PVector> jumps = new ArrayList<PVector>();
ArrayList<PVector> ups = new ArrayList<PVector>();
ArrayList<PVector> coins = new ArrayList<PVector>();
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
  posPol = new PVector (posRun.x - w/4 * size + increment, posRun.y);
  board = new PVector(w * size, 2/3 * h * size);
  newLanes();
  ob.add("duck");
  ob.add("jump");
  ob.add("up");
  newOb();
  newCoin();
  //file = new SoundFile(this, "SurfSong.mp3");
  }
  
  void gravity(){
    if(posRun.y < h/3 * size - size){
      int curY = (int) posRun.y;
      if(curY < h/3 * size){
        posRun.y ++; 
        posPol.y = posRun.y;
        curY = (int) posRun.y;
      }
      }
      
    if(posRun.y < 2*h/3 * size - size && posRun.y > h/3 * size - size){
        int curY = (int) posRun.y;
        if(curY < 2 * h/3 * size){
        posRun.y ++;
        posPol.y = posRun.y;
        curY = (int) posRun.y;
        }
      }
      if(posRun.y < h * size - 2 * size && posRun.y > 2*h/3 * size - size){
        int curY = (int) posRun.y;
      if(curY < h * size){
        posRun.y ++;
        posPol.y = posRun.y;
        curY = (int) posRun.y;
      }
      }
  }
  
  void newCoin(){
    pos = (int) random(0, 2);
    if(lane.size() > 0){
    if(lane.get(pos) == "jump"){
      coin = new PVector(jump.x - size, jump.y + 0.75 * size);
      coins.add(coin);
    }
    if(lane.get(pos) == "up"){
      coin = new PVector(up.x + size, up.y - 0.25 * size);
      coins.add(coin);
      }
    if(lane.get(pos) == "duck"){
      coin = new PVector(duck.x, duck.y + 2.75 * size);
      coins.add(coin);
      }
    }
  }
  
  void drawCoin(){
    fill(224,210,77);
    if(coin.x > - size){
      if(lane.size() > 0){
     if(lane.get(pos) == "duck" || lane.get(pos) == "up"){
       for(PVector coin : coins){
      circle(coin.x, coin.y, size / 2);
      circle(coin.x + size, coin.y, size / 2);
      circle(coin.x + 2 * size, coin.y, size / 2);
       }
     }
     else{
       for(PVector coin: coins){
       circle(coin.x, coin.y, size / 2);
       circle(coin.x + 1.5 * size, coin.y - size, size / 2);
       circle(coin.x + 2.5 * size, coin.y, size / 2);
       }
     }
      }
    }
  }
  
  void boardGen(){
    int choice = -1;
    if(second() % 20 == 0 && start == true){
      choice = (int) random(0,3);
    if(choice == 0){
    board = new PVector(w * size, jump.y);
    }
    if(choice == 1){
    board = new PVector(w * size, up.y - size);
    }
    else{
     board = new PVector(w * size, duck.y + 2 * size);
    }
    }
    fill(211,87,45);
    square(board.x, board.y, size);
    fill(255,255,255);
    textSize(50);
    text("?", board.x + size/3, board.y + size * 2/3);
  }
  
  void boardDraw(){
    fill(random(0, 256), random(0, 256), random(0,256));
    arc(legs.x, legs.y + size/4, size*0.5, size*0.5, 0, PI);
    rect(legs.x, legs.y + size/4, size * 3/4, size/4);
    arc(legs.x + size * 0.75, legs.y + size/4, size*0.5, size*0.5, 0, HALF_PI);
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
    if(squat == false){
    rect(bodyPart.x, bodyPart.y + size * 0.75, size * 1/4, size * 3/8);
    rect(bodyPart.x + size * 0.5, bodyPart.y + size * 0.75, size * 1/4, size * 3/8);
    rect(bodyPart.x - size * 0.125, bodyPart.y, size * 0.125, size * 0.5);
    rect(bodyPart.x + size * 0.75, bodyPart.y, size * 0.125, size * 0.5);
    }
    runner.add(bodyPart);

    fill(229,214,162);
    circle(posPol.x, posPol.y, size);
    fill(10,10,10);
    circle(posPol.x + 0.5 * size, posPol.y, 10);
    bodyPol = new PVector(posPol.x - 0.35 * size, posPol.y + 0.5 * size);
    fill(35, 67, 118);
    square(bodyPol.x, bodyPol.y, size * 3 / 4);
    circle(bodyPol.x, bodyPol.y, size * 1/4);
    circle(bodyPol.x + size * 0.75, bodyPol.y, size * 1/4);
    rect(posPol.x - 0.375 * size, posPol.y - size * 0.5, size * 0.75, size * 0.25);
    if(squat == false){
    rect(bodyPol.x, bodyPol.y + size * 0.75, size * 1/4, size * 3/8);
    rect(bodyPol.x + size * 0.5, bodyPol.y + size * 0.75, size * 1/4, size * 3/8);
    rect(bodyPol.x - size * 0.125, bodyPol.y, size * 0.125, size * 0.5);
    rect(bodyPol.x + size * 0.75, bodyPol.y, size * 0.125, size * 0.5);
    }
  }
  
  void squatGuy(){
    int dis = (int) posRun.x - (int) posPol.x;
    if(second() - squatStart  < 2){
    posRun.y = newPos;
    arms = new PVector(bodyPart.x + size * 0.75, bodyPart.y);
    legs = new PVector(bodyPart.x + size * 0.75, bodyPart.y + size * 0.5);
    fill(72, 10, 95);
    rect(bodyPart.x + size * 0.75, bodyPart.y + size * 0.25, size * 1/4, size * 3/8);
    rect(bodyPart.x + size, bodyPart.y + size * 0.25, size * 1/4, size/2);
    rect(arms.x, arms.y, size, size * 0.125);
    //rect(legs.x,legs.y, size, size * 0.125);
    fill(35, 67, 118);
    posPol.y = newPos;
    rect(arms.x - dis, arms.y, size, size * 0.125);
    //rect(legs.x - dis,legs.y, size, size * 0.125);
    rect(bodyPart.x + size * 0.75 - dis, bodyPart.y + size * 0.25, size * 1/4, size * 3/8);
    rect(bodyPart.x + size - dis, bodyPart.y + size * 0.25, size * 1/4, size/2);
    }
    else{
      squat = false;
      posRun.y -= size;
    }
  }
  
  void moveLimbs(){
    fill(72, 10, 95);
    arms = new PVector(bodyPart.x - size * 0.125, bodyPart.y + size * 0.5);
    legs = new PVector(bodyPart.x, bodyPart.y + size * 9/8);
    aPol = new PVector(bodyPol.x - size * 0.125, bodyPol.y + size * 0.5);
    lPol = new PVector(bodyPol.x, bodyPol.y + size * 9/8);
    runner.add(arms);
    runner.add(legs);
    if(start == false || boardTouch == true){
    rect(arms.x, arms.y, size * 0.125, size * 0.5);
    rect(arms.x + size * 0.875, arms.y, size * 0.125, size * 0.5);
    rect(legs.x, legs.y, size * 1/4, size * 3/8);
    rect(legs.x + size * 0.5,legs.y, size * 1/4, size * 3/8);
    }
    if(start == false){
    fill(35, 67, 118);
    rect(aPol.x, aPol.y, size * 0.125, size * 0.5);
    rect(aPol.x + size * 0.875, aPol.y, size * 0.125, size * 0.5);
    rect(lPol.x, lPol.y, size * 1/4, size * 3/8);
    rect(lPol.x + size * 0.5,lPol.y, size * 1/4, size * 3/8);
    }
    int dis = (int) posRun.x - (int) posPol.x;
    if(start == true){
    if (second() % 2 == 0){
      if(boardTouch == false){
      rect(arms.x, arms.y, size * 0.125, size * 0.5);
      rect(arms.x + size * 0.875, arms.y, size * 0.5, size * 0.125);
      rect(legs.x - size * 3/8 + size * 1/4, legs.y, size * 3/8, size * 1/4);
      rect(legs.x + size * 0.5,legs.y, size * 1/4, size * 3/8);
      }
      //savedTime = millis();
      fill(35, 67, 118);
      rect(arms.x - dis, arms.y, size * 0.125, size * 0.5);
      rect(arms.x + size * 0.875 - dis, arms.y, size * 0.5, size * 0.125);
      rect(legs.x - size * 3/8 + size * 1/4 - dis, legs.y, size * 3/8, size * 1/4);
      rect(legs.x + size * 0.5 - dis,legs.y, size * 1/4, size * 3/8);
    }
    else{
      if(boardTouch == false){
      rect(arms.x, arms.y, size * 0.5, size * 0.125);
      rect(arms.x + size * 0.875, arms.y, size * 0.125, size * 0.5);
      rect(legs.x, legs.y, size * 1/4, size * 3/8);
      rect(legs.x + size * 0.5 - size * 3/8 + size * 1/4,legs.y, size * 3/8, size * 1/4);
      }
      fill(35, 67, 118);
      rect(arms.x - dis, arms.y, size * 0.5, size * 0.125);
      rect(arms.x + size * 0.875 - dis, arms.y, size * 0.125, size * 0.5);
      rect(legs.x - dis, legs.y, size * 1/4, size * 3/8);
      rect(legs.x + size * 0.5 - size * 3/8 + size * 1/4 - dis,legs.y, size * 3/8, size * 1/4);
      
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
    if(squat == false){
    moveLimbs();
    }
    newLanes();
    if(frameCount % speed == 0){
    if (duck.x < - size){
       newOb();
       if(second() % 10 == 0){
       speed -= 0.25;
       }
    }
    updateOb();
    }
    frameCount ++;
    drawOb();
    if(boardTouch == false){
    gravity();
    }
    if(coin.x < - size){
    newCoin();
    }
    drawCoin();
    updateGuy();
    if(start == false){
    textSize(70);
    fill(255,255,255);
    text("High Score: " + highScore, posRun.x, posRun.y + size * 3);
    }
    else{
    textSize(50);
    fill(255,255,255);
    text("Current Score: " + currentScore, 0, h * size + size * 3/4);
    }
    if(squat == true){
      squatGuy();
    }
    boardGen();
    if(boardTouch == true && second() - boardTime < 16){
      boardDraw();
    }
    else{
      boardTouch = false;
    }
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
    board.x -= 0.5 * size;
    for(PVector coin: coins){
    coin.x -= 0.5 * size;
    }
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
    posPol.y = posRun.y;
    if(runner.size() > 0 ){
      runner.remove(0);
    }
    if(lane.size() > 0){
      if(legs.y < h/3 * size + size){
        lanes = 0;
      }
      if(legs.y > h/3 * size + size && legs.y < 2*h/3 * size + size){
        lanes = 1;
      }
      if(legs.y > 2*h/3 * size + size){
        lanes = 2;
      }
      if(lane.get(lanes) == "duck"){
        if(posRun.x - size/2 < duck.x && posRun.x + size/2 > duck.x && posRun.y - size * 1.5 < duck.y && posRun.y + size * 1.5 > duck.y ){
          increment += size/2;
          reset();
        }
      }
      if(lane.get(lanes) ==  "jump"){
        if(legs.x - size/4 < jump.x && legs.x + size/4 > jump.x && legs.y - size < jump.y && legs.y + size/2 > jump.y ){
          increment += size/2;
          reset();
      }
      }
      if(lane.get(lanes) == "up"){
        if(legs.x < up.x + size * 10 && legs.x > up.x && legs.y - size * 1.5 < up.y && legs.y + size * 1.5 > up.y ){
          if(legs.y > up.y){
          posRun.y = up.y - 2 * size;
          }
        }
    }
    if(legs.x - size/2 < coin.x && legs.x > coin.x && legs.y - size/2 < coin.y && legs.y + size/2 > coin.y){
        currentScore ++;
        if(currentScore > highScore){
          highScore = currentScore;
        } 
    }
    if (posRun.x == posPol.x + size){
      reset();
      textSize(50);
      fill(255,255,255);
      text("GAME OVER: YOU GOT CAUGHT", 0, h * size + size * 3/4);
    }
  }
  if(posRun.x > board.x + 40 && posRun.y < board.y + 40 && posRun.y > board.y - 40 || legs.x > board.x + 40 && legs.y < board.y + 40 && legs.y > board.y - 40){
    boardTime = second();
    boardTouch = true;
  }
  }

  void keyPressed(){
    if(key == CODED){
      if(keyCode == RIGHT){
        if(start == false){
          //file.play();
        }
       start = true;
      }
      if(keyCode == UP){
       
        if(posRun.y > 0){
          if(boardTouch == false){
        posRun.set(new PVector(posRun.x, posRun.y - 3/2 * size));
        posPol.set(new PVector(posPol.x, posPol.y - 3/2 * size));
          }
          else{
            posRun.y -=10;
            posPol.y -=10;
        //posRun.set(new PVector(posRun.x, posRun.y - 2 * size));
        //posPol.set(new PVector(posPol.x, posPol.y - 2 * size));
        }
      }
      }
      if(keyCode == DOWN){
          if(boardTouch == false){
            if(posRun.y < h * size - 3 * size){
        posRun.set(new PVector(posRun.x, posRun.y + 3/2 * size));
        posPol.set(new PVector(posPol.x, posPol.y + 3/2 * size));
            }
          }
          else{
            if(posRun.y < h * size - 2 * size){
            posRun.y +=10;
            posPol.y +=10;
            }
            //posRun.set(new PVector(posRun.x, posRun.y + 2 * size));
            //posPol.set(new PVector(posPol.x, posPol.y + 2 * size));
          }
      }
      if(squat == false){
      if(keyCode == LEFT){
        squatStart = second();
        newPos = (int) (posRun.y + size * 0.7);
        squat = true;
      }
      }
    }
  }
  
  void reset(){
    //file.stop();
    setup();
    //posPol.x += increment;
    currentScore = 0;
    println("reset");
    background(200);
    background(bgrd);
    frameRate(60);
  fill(77,73,73);
  size(1300, 878);
  savedTime = millis();
  w = width / size;
  h = height / size;
  //posRun = new PVector (w/4 * size, h/2 * size);
  //posPol = new PVector (w/8 * size, h/2 * size);
  newLanes();
  ob.add("duck");
  ob.add("jump");
  ob.add("up");
  newOb();
  start = false;
  } 
