class Player extends Actor {
  
  int score = 0;
  int[][] distances = new int[WIDTH][HEIGHT];

  Player(int startX, int startY){
    super(startX, startY);
  }
  
  void draw(float displayX, float displayY, float t, float rotate){
    fill(255, 255, 0);
    float angle = abs(t - 0.5) * 2 * PI / 4; // Werte von 0.0 bis PI / 4
    arc((displayX + 0.5) * FIELD_SIZE, (displayY + 0.5) * FIELD_SIZE, FIELD_SIZE, FIELD_SIZE, 
        PI + angle + rotate, 3 * PI - angle + rotate );
  }
  
  void move(){
    super.move();
    calculateDistances();
    if(points[oldX][oldY]){
        points[oldX][oldY] = false;
        score ++;
    }
  }
  
  void calculateDistances(){
    for (int i = 0; i < WIDTH; i++){
      for (int j = 0; j < HEIGHT; j++){
        distances[i][j] = -1;
      }
    }
    ArrayList<Point> todo = new ArrayList();
    todo.add(new Point(x, y));
    
    while(todo.size() > 0){
      Point point = todo.remove(0);
      ArrayList<Point> neighbours = point.getNeighbours();
      
      for(Point neighbour: neighbours){
        if (!walls[neighbour.x][neighbour.y] && distances[neighbour.x][neighbour.y] == -1){
          distances[neighbour.x][neighbour.y] = distances[point.x][point.y] +1;
          todo.add(neighbour);
        }
      }
    }
  }
}
