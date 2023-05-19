PVector posRun;
PVector posPol;
int speed = 20;
int size = 40;
int w;
int h;
  
void setup(){
  frameRate(60);
  fill(77,73,73);
  size(1080, 720);
  w = width / size;
  h = height / size;
  posRun = new PVector (w/4, h/2);
  posPol = new PVector (w/8, h/2);
  newLanes();
  
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
  
  void newOb(){
    
  }
  
  void keyPressed(){
  }
  
  void reset(){
  }
