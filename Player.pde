class Player {
  int ticksPerMove = 10;
  int x, y; // Zielposition
  int direction = RIGHT;
  
  int oldX, oldY; // Startposition
  int moveX, moveY; // Richtungsvektor zwischen Start- und Zielposition
  int oldDirection = RIGHT;
  
  int score = 0;

  Player(int startX, int startY) {
    x = startX;
    y = startY;
  }

  void draw() {
    fill(255, 255, 0);
    float rotate = (oldDirection - LEFT) * PI / 2;
    float t = (ticks % ticksPerMove) / float(ticksPerMove); // Werte von 0.0 bis 1.0
    float displayX = oldX + t * moveX;
    float displayY = oldY + t * moveY;
    float angle = abs(t - 0.5) * 2 * PI / 4; // Werte von 0.0 bis PI / 4
    
    arc((displayX + 0.5) * FIELD_SIZE, (displayY + 0.5) * FIELD_SIZE, FIELD_SIZE, FIELD_SIZE, 
        PI + angle + rotate, 3 * PI - angle + rotate );
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
      if(points[oldX][oldY]){
        points[oldX][oldY] = false;
        score ++;
      }
    }
  }
}
