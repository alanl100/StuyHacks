// p1
final int KW = 10;
final int KA = 11;
final int KS = 12;
final int KD = 13;
final int KX = 14;
// p2o
final int KI = 15;
final int KJ = 16;
final int KK = 17;
final int KL = 18;
final int KO = 19;
final int KSPACE = 20;

boolean paused;
int timer;

boolean[] keys;
ArrayList<Bullet> bullets;
ArrayList<Rectangle> walls;
PImage map;
Player p1;
Player p2;

void setup() {
  paused = false;
  size(800,500);
  frameRate(60);
  keys = new boolean[21];
  bullets = new ArrayList<Bullet>();
  walls = new ArrayList<Rectangle>();
  map = loadImage("map.jpg");
  p1 = new Player(0.25 * width, 0.75 * height, 0, "player1.png");
  p2 = new Player(0.75 * width, 0.25 * height, 0, "player2.png");
  createRects();
}

// draw 
void draw() {
  background(240);
  image(map, 0, 0);
  realKeyPressed();
  drawUI();
  display();
  if (timer>0) {timer--;}
  if (paused) {

  }
  else {
    playerManager();
    bulletManager();
  }
}

void display() {
  // show map
  // show players
  for (int i = 0; i < bullets.size(); i++){
    bullets.get(i).pDisplay();
  }
  for (int i = 0; i < walls.size(); i++){
    walls.get(i).drawRectangle();
  }
  p1.pDisplay();
  p2.pDisplay();
}

// method that works as a real keypressed method
// PUT KEY FUNCTIONS IN HERE
void realKeyPressed() { // PUT STUFF HERE
  if (!paused) {
    if (keys[KW]) {p1.move(0,-1,walls);}
    if (keys[KS]) {p1.move(0,1,walls);}
    if (keys[KA]) {p1.move(-1,0,walls);}
    if (keys[KD]) {p1.move(1,0,walls);}
    if (keys[KX]) {p1.createBullet(bullets);}
    if (keys[KI]) {p2.move(0,-1,walls);}
    if (keys[KK]) {p2.move(0,1,walls);}
    if (keys[KJ]) {p2.move(-1,0,walls);}
    if (keys[KL]) {p2.move(1,0,walls);}
    if (keys[KO]) {p2.createBullet(bullets);}
  }
  if (keys[KSPACE]&&timer==0) {paused=!paused;timer=10;}
}

// these two methods only toggle and trigger keys array
void keyPressed() {
  if (key=='w') {keys[KW] = true;}
  if (key=='s') {keys[KS] = true;}
  if (key=='a') {keys[KA] = true;}
  if (key=='d') {keys[KD] = true;}
  if (key=='x') {keys[KX] = true;}
  if (key=='i') {keys[KI] = true;}
  if (key=='j') {keys[KJ] = true;}
  if (key=='k') {keys[KK] = true;}
  if (key=='l') {keys[KL] = true;}
  if (key==',') {keys[KO] = true;} // used to be o
  if (key==' ') {keys[KSPACE] = true;}
}
void keyReleased() {
  if (key=='w') {keys[KW] = false;}
  if (key=='s') {keys[KS] = false;}
  if (key=='a') {keys[KA] = false;}
  if (key=='d') {keys[KD] = false;}
  if (key=='x') {keys[KX] = false;}
  if (key=='i') {keys[KI] = false;}
  if (key=='j') {keys[KJ] = false;}
  if (key=='k') {keys[KK] = false;}
  if (key=='l') {keys[KL] = false;}
  if (key==',') {keys[KO] = false;} // used to be o
  if (key==' ') {keys[KSPACE] = false;}
  
}

void bulletManager() {
  // kill dead bullets
  for (int i=0;i<bullets.size();i++) {
    // bullets
    // check if is on walls
    for (int w=0;w<walls.size();w++) {
      //if (walls.get(w).isTouchingHorizontal((int)bullets.get(i).position.x,(int)bullets.get(i).position.y)) {
      if (walls.get(w).isTouchingWall(bullets.get(i).position.x,bullets.get(i).position.y)) {
        bullets.get(i).bounceX();
      }
      if (walls.get(w).isTouchingWall(bullets.get(i).position.x,bullets.get(i).position.y)) {
        bullets.get(i).bounceY();
      }
    }
    // hurt players
    if (p1.position.dist(bullets.get(i).position) < bullets.get(i).size) {
      bullets.get(i).drainPlayer(p1);
    }
    if (p2.position.dist(bullets.get(i).position) < bullets.get(i).size) {
      bullets.get(i).drainPlayer(p2);
    }
    if (bullets.get(i).position.x <= 0) {
      bullets.get(i).speed.x = -bullets.get(i).speed.x;
    }
    if (bullets.get(i).position.y <= 0) {
      bullets.get(i).speed.y = -bullets.get(i).speed.y;
    }
    if (bullets.get(i).position.x >= width) {
      bullets.get(i).speed.x = -bullets.get(i).speed.x;
    }
    if (bullets.get(i).position.y >= height) {
      bullets.get(i).speed.y = -bullets.get(i).speed.y;
    }
    
    // move
    bullets.get(i).move();
    
    // check all bullets for those marked to die
    if (bullets.get(i).shouldDie==true) {
      bullets.remove(i);
    }
  }
}

void playerManager() {
  // movement
  p1.pDisplay();
  p2.pDisplay();
  p1.turnDirection();
  p2.turnDirection();
  
}

void drawUI() {
  if (paused) {
    fill(255);
    rect(30,15,20,60);
    rect(70,15,20,60);
  }
  //stroke(255,0,0);
  fill(255,0,0);
  textAlign(BOTTOM);
  textSize(20);
  text("hp:" + p1.health,200, height - 100);
  //stroke(0,0,255);
  text("hp:" + p2.health,width - 200, height - 100);
}

void createRects() {
  // width is the max x
  // height is the max y
  /*walls.add(new Rectangle(width/2 - 50, height/2 - 50, width/2 + 50, height/2 + 50));
  walls.add(new Rectangle(200, height - 300, 250, 300));
  walls.add(new Rectangle(width - 250, height - 300, width - 200, 300));
  walls.add(new Rectangle(width/2 - 200, height - 100, width/2 + 200, height - 200));
  walls.add(new Rectangle(width/2 - 200, 200, width/2 + 200, 100));*/
  walls.add(new Rectangle(width/2 - width/10,height/5,width/10,2*height/5));
}
