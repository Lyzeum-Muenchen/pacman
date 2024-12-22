abstract class Actor {
  int ticksPerMove = 10;
  int startX, startY;
  int x, y; // Zielposition
  int direction = RIGHT;
  
  int oldX, oldY; // Startposition
  int moveX, moveY; // Richtungsvektor zwischen Start- und Zielposition
  int oldDirection = RIGHT;
  

  Actor(int startX, int startY) {
    this.startX = startX;
    this.startY = startY;
    x = startX;
    y = startY;
    oldX = x;
    oldY = y;
  }
  
  abstract void draw(float displayX, float displayY, float t, float rotate);

  void draw() {
    
    float rotate = (oldDirection - LEFT) * PI / 2;
    float t = (ticks % ticksPerMove) / float(ticksPerMove); // Werte von 0.0 bis 1.0
    float displayX = oldX + t * moveX;
    float displayY = oldY + t * moveY;
    
    draw(displayX, displayY, t, rotate);
    
  }

  void move() {
    if (ticks % ticksPerMove == 0) {
      oldX = x;
      oldY = y;
      oldDirection = direction;
      switch(direction) {
      case LEFT:
        x--;
        break;
      case RIGHT:
        x++;
        break;
      case UP:
        y--;
        break;
      case DOWN:
        y++;
        break;
      }
      moveX = x - oldX;
      moveY = y - oldY;
      
      x = (x+WIDTH) % WIDTH;
      y = (y+HEIGHT) % HEIGHT;
      if (walls[x][y]){
        x = oldX;
        y = oldY;
        moveX = 0;
        moveY = 0;
      }
    }
  }
  
  void reset(){
    oldX = x = startX;
    oldY = y = startY;
    oldDirection = direction = RIGHT;
    moveX = moveY = 0;
  }
}
