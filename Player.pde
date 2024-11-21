class Player {
  int ticksPerMove = 10;
  int x, y;
  int oldX, oldY;
  int moveX, moveY;
  int direction = RIGHT;
  int oldDirection = RIGHT;

  Player(int startX, int startY) {
    x = startX;
    y = startY;
    oldX = x;
    oldY = y;
  }

  void draw() {
    fill(255, 255, 0);
    float rotate = (oldDirection - LEFT) * PI / 2;
    float t = (ticks%ticksPerMove)/float(ticksPerMove);
    float displayX = oldX + t * moveX;
    float displayY = oldY + t * moveY;
    float angle = abs(t - 0.5) * 2 * PI / 4;
    arc((displayX+0.5)*FIELD_SIZE, (displayY+0.5)*FIELD_SIZE, FIELD_SIZE, FIELD_SIZE, PI + angle + rotate, 3*PI - angle + rotate );
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
      points[oldX][oldY] = false;
    }
  }
}
