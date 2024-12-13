class Ghost extends Actor {
  Ghost(int startX, int startY){
    super(startX, startY);
  }
  
  void draw(float displayX, float displayY, float t, float rotate){
    fill(255,0,0);
    rect((displayX + 0.1) * FIELD_SIZE, (displayY + 0.1) * FIELD_SIZE, 0.8*FIELD_SIZE, 0.8*FIELD_SIZE);
  }
  
  void move(){
    if(ticks % ticksPerMove == 0){
      ArrayList<Integer> possibleDirections = new ArrayList();
      
      if (! walls [(x+1)%WIDTH] [y]) possibleDirections.add(RIGHT);
      if (! walls [x] [(y+1)%HEIGHT]) possibleDirections.add(DOWN);
      if (! walls [(x-1+WIDTH) % WIDTH] [y]) possibleDirections.add(LEFT);
      if (! walls [x] [(y-1+WIDTH) % HEIGHT]) possibleDirections.add(UP);
      
      int backwards = (direction - LEFT + 2) % 4 + LEFT;
      if (possibleDirections.size() > 1) possibleDirections.remove((Integer)backwards);
            
      int index = floor(random(possibleDirections.size()));
      direction = possibleDirections.get(index);
    }
    
    super.move();
    
    int backwards = (direction - LEFT + 2) % 4 + LEFT;
    if ((p.x == x && p.y == y) || (backwards == p.direction && p.oldX == x && p.oldY == y)){
      shallReset = true;
    }
  }
}
