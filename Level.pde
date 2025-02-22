class Level{
  Map map;
  ArrayList<Ghost> levelGhosts = new ArrayList();
  final color[] colors = {#FF0000, #FFB8FF, #00FFFF, #FFB852};
  
  Level(Map map){
    this.map = map;
  }
  
  Level(String description){
    String[] parts = description.split(" ");
    map = new Map(parts[0]);
    for(int i= 0; i < (parts.length - 1)/2;i++ ){
      if(!parts[2*i+1].equals("-")){
        float difficulty = float(parts[2*i+1]);
        int waitingTime = int(parts[2*i+2]);
        levelGhosts.add(
          new Ghost(map.ghostStarts[i].x, map.ghostStarts[i].y, colors[i], waitingTime, difficulty)
        );
      }
    }
    
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
    
    
    ghosts = levelGhosts;
    for(Ghost ghost: levelGhosts){
      ghost.reset();
    }
    
    p.startX = map.playerX;
    p.startY = map.playerY;
    
    p.reset();
    
  }
  
}
