class Ghost extends Actor {
  Ghost(int startX, int startY){
    super(startX, startY);
  }
  
  void draw(float displayX, float displayY, float t, float rotate){
    fill(255,0,0);
    rect((displayX + 0.1) * FIELD_SIZE, (displayY + 0.1) * FIELD_SIZE, 0.8*FIELD_SIZE, 0.8*FIELD_SIZE);
  }
  
  int chooseDirection(){
    float[] probabilities = new float [4];
    float sum = 0;
    ArrayList<Point> neighbours = new Point(x,y).getNeighbours();
    for(int i= 0; i< 4; i++){
      Point n = neighbours.get(i);
      if(p.distances[n.x][n.y] != -1){
        probabilities[i] = exp(- p.distances[n.x][n.y] * 1.0 + 10);
        sum = sum+ probabilities[i]; // sum += probabilities[i]
      }
    }
    int backwards = (direction - LEFT + 2) % 4;
    if(sum > probabilities[backwards]){
      sum -= probabilities[backwards];
      probabilities[backwards] = 0;
    }
    
    float rand = random(sum);
    
    float partialSum = 0;
    for (int newDirection = 0; newDirection < 4; newDirection++){
      partialSum += probabilities[newDirection];
      if(rand <= partialSum) return LEFT + newDirection;
    }
    return LEFT + 3;
  }
  
  void move(){
    if(ticks % ticksPerMove == 0){
      direction = chooseDirection();
    }
    
    println(direction - LEFT);
    
    super.move();
    
    int backwards = (direction - LEFT + 2) % 4 + LEFT;
    if (resetIn < 0){
      if (p.x == x && p.y == y){
        resetIn = p.ticksPerMove;
        println("Selbes Feld");
      } else if (backwards == p.direction && p.oldX == x && p.oldY == y) {
        resetIn = p.ticksPerMove / 2;
        println("Kollision");
      }
    }
  }
}
