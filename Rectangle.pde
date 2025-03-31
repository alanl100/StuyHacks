class Rectangle {

  PVector corner1;
  PVector corner2;
  color c;
  PVector wH;

  Rectangle(float x1,float y1,float w,float h,color c) {
    corner1 = new PVector(x1,y1);
    corner2 = new PVector(x1 + w,y1 + h);
    wH = new PVector(w,h);
    this.c = #33ac7c;
  }

  Rectangle(float x1, float y1, float w, float h) {
    this(x1,y1,w,h,#33ac7c);
  }

  void drawRectangle() {
    fill(c);
    rect(corner1.x,corner1.y,wH.x,wH.y);
  }

  /*boolean isTouchingVertical(int x, int y) {
    return (x+1 <= corner2.x && x+1 >= corner1.x) && (y <= corner1.x && y >= corner2.y) || (x-1 <= corner2.x && x-1 >= corner1.x) && (y <= corner1.x && y >= corner2.y);
  }

  boolean isTouchingHorizontal(int x, int y) {
    return (x <= corner2.x && x >= corner1.x) && (y+1 <= corner1.x && y+1 >= corner2.y) || (x <= corner2.x && x >= corner1.x) && (y-1 <= corner1.x && y-1 >= corner2.y);
  }*/
  
  boolean isTouchingWall(float x, float y) {
    if (x > corner1.x && x < corner2.x && y < corner2.y && y > corner1.y) {
      return true;
    }
    return false;
  }
  
  PVector canPassThrough(float x, float y, float speed) {
    if (isTouchingWall(x+speed,y)) {
        x-=speed;
    }
    if (isTouchingWall(x-speed,y)) {
        x+=speed;
    }
    if (isTouchingWall(x,y+speed)) {
      y-=speed;
    }
    if (isTouchingWall(x,y-speed)) {
      y+=speed;
    }
    return new PVector(x,y);
  }

}
