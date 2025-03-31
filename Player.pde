class Player {
  
  PVector position;
  int health; // out of 100? or 10?
  float direction; // radians, determines direction gun is pointing
  float speed;  // what is the unit? is this movement speed?
  int damage;   // damage a bullet shot from this player has
  float size; // temp
  PImage sprite;
  color c;
  float distBulletSpawn;

  Player(float x, float y, float direction, String spritePath) {
    position = new PVector(x,y);
    health = 100;
    this.direction = direction;
    speed = 2;
    size = 25;
    distBulletSpawn = 25;
    sprite = loadImage(spritePath);
    sprite.resize(25,25);
    if (x<width/2) {
      c = color(255,0,0);
    } else {
     c = color(0,0,255); 
    }
  }
  
  void pDisplay() {
    fill(c);
    circle(position.x,position.y,size);
    image(sprite, position.x - 13, position.y - 13);
    stroke(0,255,0);
    line(position.x,position.y,position.x + cos(direction)*distBulletSpawn,position.y + sin(direction)*distBulletSpawn);
    stroke(0);
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if (health < 0){
      health = 0;
    }
  }

  void createBullet(ArrayList<Bullet> b) {
    b.add(new Bullet(position.x + distBulletSpawn*(cos(direction)),position.y + distBulletSpawn*(sin(direction)),cos(direction),sin(direction),damage,this,"bullet1.png"));
  }

  void move(int xDirection, int yDirection,ArrayList<Rectangle> array) {
    if (position.x < size) {position.x = size;}
    if (position.x > width - size) {position.x = width - size;}
    if (position.y < size) {position.y = size;}
    if (position.y > height - size) {position.y = height - size;}
    PVector temp = new PVector(xDirection, yDirection);temp.normalize();
    for (int i=0;i<array.size();i++) {
      position.x = array.get(i).canPassThrough(position.x,position.y,speed).x;
      position.y = array.get(i).canPassThrough(position.x,position.y,speed).y;
    }
    position.x+=temp.x * speed;
    position.y+=temp.y * speed;
  }

  void turnDirection(){
    direction += PI/36;
  }

}
