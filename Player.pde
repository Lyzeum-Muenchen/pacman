class Player {
  int speed = 10;
  int x, y;
  int direction = RIGHT;

  Player(int startX, int startY) {
    x = startX;
    y = startY;
  }

  void draw() {
    fill(255, 255, 0);
    float rotate = (direction - LEFT) * PI / 2;
    arc((x+0.5)*FIELD_SIZE, (y+0.5)*FIELD_SIZE, FIELD_SIZE, FIELD_SIZE, PI + PI / 8 + rotate, 3*PI - PI / 8 + rotate );
  }

  void move() {
    if (ticks % 10 == 0) {
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
      x = (x+WIDTH) % WIDTH;
      y = (y+HEIGHT) % HEIGHT;
    }
  }
}
