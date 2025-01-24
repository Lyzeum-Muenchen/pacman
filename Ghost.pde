class Ghost extends Actor {

  color fillColor;
  int waitingTime;
  int waitingTimer;

  Ghost(int startX, int startY, color fillColor, int waitingTime) {
    super(startX, startY);
    this.fillColor = fillColor;
    this.waitingTime = waitingTime;
    reset();
  }

  void draw(float displayX, float displayY, float t, float rotate) {
    fill(fillColor);
    rect(displayX * FIELD_SIZE, (displayY + 0.5) * FIELD_SIZE, FIELD_SIZE, 0.5 * FIELD_SIZE - FIELD_SIZE / 6);
    arc((displayX + 0.5) * FIELD_SIZE, (displayY + 0.5) * FIELD_SIZE, FIELD_SIZE, FIELD_SIZE, 0.9 * PI, 2.1 * PI);
    if (ticks % 8 > 4) {
      triangle(displayX * FIELD_SIZE, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, displayX * FIELD_SIZE + FIELD_SIZE / 3, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, displayX * FIELD_SIZE + FIELD_SIZE / 6, (displayY + 1) * FIELD_SIZE);
      triangle(displayX * FIELD_SIZE + FIELD_SIZE / 3, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, displayX * FIELD_SIZE + FIELD_SIZE / 1.5, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, displayX * FIELD_SIZE + FIELD_SIZE / 6 + FIELD_SIZE / 3, (displayY + 1) * FIELD_SIZE);
      triangle((displayX + 1) * FIELD_SIZE, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, (displayX + 1) * FIELD_SIZE - FIELD_SIZE / 3, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, (displayX + 1) * FIELD_SIZE - FIELD_SIZE / 6, (displayY + 1) * FIELD_SIZE);
    } else {
      circle(displayX * FIELD_SIZE + FIELD_SIZE / 6, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, FIELD_SIZE / 3);
      circle((displayX + 0.5) * FIELD_SIZE, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, FIELD_SIZE / 3);
      circle((displayX + 1) * FIELD_SIZE - FIELD_SIZE / 6, (displayY + 1) * FIELD_SIZE - FIELD_SIZE / 6, FIELD_SIZE / 3);
    }
    fill(255, 255, 255);
    circle((displayX + 0.25) * FIELD_SIZE, (displayY + 0.4) * FIELD_SIZE, 0.2 * FIELD_SIZE);
    circle((displayX + 0.75) * FIELD_SIZE, (displayY + 0.4) * FIELD_SIZE, 0.2 * FIELD_SIZE);
    fill(0, 0, 0);
    circle((displayX + 0.25 + cos(rotate-PI)*0.05) * FIELD_SIZE, (displayY + 0.4 + sin(rotate-PI)*0.05) * FIELD_SIZE, 0.1 * FIELD_SIZE);
    circle((displayX + 0.75 + cos(rotate-PI)*0.05) * FIELD_SIZE, (displayY + 0.4 + sin(rotate-PI)*0.05) * FIELD_SIZE, 0.1 * FIELD_SIZE);
  }

  int chooseDirection() {
    float[] probabilities = new float [4];
    float sum = 0;
    ArrayList<Point> neighbours = new Point(x, y).getNeighbours();
    for (int i= 0; i< 4; i++) {
      Point n = neighbours.get(i);
      if (p.distances[n.x][n.y] != -1) {
        probabilities[i] = exp(- (p.distances[n.x][n.y] - p.distances[x][y]) * 2.0);
        sum = sum + probabilities[i]; // sum += probabilities[i]
      }
    }
    int backwards = (direction - LEFT + 2) % 4;
    if (sum > probabilities[backwards]) {
      sum -= probabilities[backwards];
      probabilities[backwards] = 0;
    }

    float rand = random(sum);

    float partialSum = 0;
    for (int newDirection = 0; newDirection < 4; newDirection++) {
      partialSum += probabilities[newDirection];
      if (rand <= partialSum) return LEFT + newDirection;
    }
    return LEFT + 3;
  }

  void move() {
    if (ticks % ticksPerMove == 0) {
      direction = chooseDirection();
      if (waitingTimer > 0) waitingTimer --;
    }

    if (waitingTimer <= 0) {
      super.move();

      int backwards = (direction - LEFT + 2) % 4 + LEFT;
      if (resetIn < 0) {
        if (p.x == x && p.y == y) {
          resetIn = p.ticksPerMove;
          println("Selbes Feld");
        } else if (backwards == p.direction && p.oldX == x && p.oldY == y) {
          resetIn = p.ticksPerMove / 2;
          println("Kollision");
        }
      }
    }
  }

  void reset() {
    super.reset();
    waitingTimer = waitingTime;
  }
}
