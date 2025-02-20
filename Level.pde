class Level{
  
  Map map;
  
  Level(Map map){
    this.map = map;
  }
  
  void start(){
    walls = new boolean[WIDTH][HEIGHT];
    points = new boolean[WIDTH][HEIGHT];
    powerups = new boolean[WIDTH][HEIGHT];
    
    for (int i = 0; i < WIDTH; i++) {
      for (int j = 0; j < HEIGHT; j++) {
        walls[i][j] = map.walls[i][j];
        points[i][j] = map.points[i][j];
        powerups[i][j] = map.powerups[i][j];
      }
    }
    
    doorX = map.doorX;
    doorY = map.doorY;
    
    p.startX = map.playerX;
    p.startY = map.playerY;
    
    p.reset();
    
  }
  
}
