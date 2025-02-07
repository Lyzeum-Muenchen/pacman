class Ghost extends Actor {

  color fillColor;
  int waitingTime;
  int waitingTimer;
  int powerupTimer;
  int resetGhostIn = -1;
  int normalTicksPerMove;
  float slowdown = 0.5;

  Ghost(int startX, int startY, color fillColor, int waitingTime) {
    super(startX, startY);
    this.fillColor = fillColor;
    this.waitingTime = waitingTime;
    normalTicksPerMove = ticksPerMove;
    reset();
  }

  void draw(float displayX, float displayY, float t, float rotate) {
    fill(fillColor);
    if (powerupTimer > POWERUP_DURATION / 5 || (powerupTimer > 0 && (ticks / 4) % 2 == 0)) fill(#2121DE);

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
        float sign = -1;
        if (powerupTimer > 0) sign = +1;
        probabilities[i] = exp(sign * (p.distances[n.x][n.y] - p.distances[x][y]) * 2.0);
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
    if (powerupTimer > 0) powerupTimer --;
    if (powerupTimer == 0) {
      ticksPerMove = normalTicksPerMove;
    }
    if (resetGhostIn > 0) resetGhostIn --;
    else if (resetGhostIn == 0){
      reset();
      waitingTimer = 0;
    }

    if (ticks % ticksPerMove == 0) {
      direction = chooseDirection();
      if (waitingTimer > 0) waitingTimer --;
    }

    if (waitingTimer <= 0) {
      super.move();

      int collisionIn = -1;
      if (p.x == x && p.y == y) {
        collisionIn = p.ticksPerMove;
        println("Selbes Feld");
      } else if (oldX == p.x && oldY == p.y && p.oldX == x && p.oldY == y) {
        collisionIn = p.ticksPerMove / 2;
        println("Kollision");
      }
      
      if (collisionIn != -1){
        if(powerupTimer == 0 && resetIn < 0){
          resetIn = collisionIn;
        } else if (powerupTimer > 0 && resetGhostIn < 0){
          resetGhostIn = collisionIn;
          p.score += p.currentPointsPerGhost;
          p.currentPointsPerGhost *= 2;
        }
      }
      
    }
  }

  void reset() {
    super.reset();
    waitingTimer = waitingTime;
    resetGhostIn = -1;
    powerupTimer = 0;
    ticksPerMove = normalTicksPerMove;
  }
}
