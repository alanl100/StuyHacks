class Bullet {
  
  PVector position;
  float angle; // radians
  PVector speed;
  Player immune;
  int damage;
  float size;
  boolean shouldDie;
  PImage sprite;
  int bounces;
    
  Bullet(float x, float y, float xSpeed, float ySpeed, int damage, Player immune, String spritePath) {
    position = new PVector(x,y);
    speed = new PVector(xSpeed,ySpeed);
    this.damage = damage;
    this.angle = angle;
    size = 5;
    shouldDie = false;
    sprite = loadImage(spritePath);
    bounces = 5;    
  }
  
  void bounceX() {
    speed.x = -speed.x;
  }

  void bounceY() {
    speed.y = -speed.y;
  }

  void pDisplay() {
    circle(position.x,position.y,size);
  }
  
  void drainPlayer(Player other) {
    if (immune!=other) {
      other.takeDamage(damage);
      //shouldDie = true;
    }
  }

  void move() {
    position.x += speed.x;
    position.y += speed.y;
  }

  boolean outOfBounds() {
    return position.x < 0 || position.x > width || position.y > height || position.y < 0;
  }

}
