class Level{
  
  Map map;
  
  ArrayList<Ghost> levelGhosts = new ArrayList();
  final color[] colors = {#FF0000, #FFB8FF, #00FFFF, #FFB852};
  
  // Nur zum Testen
  Level(Map map){
    this.map = map;
  }
  
  Level(String description){
    String[] attributes = description.split(" ");
    map = new Map(attributes[0]);
    for (int i = 0; i < (attributes.length - 1) / 2; i++){
      float difficulty = float(attributes[2*i+1]);
      int waitingTime = int(attributes[2*i+2]);
      if (! Float.isNaN(difficulty)){ // NaN = keine valide Zahl
        levelGhosts.add(new Ghost(map.ghostStarts[i].x, map.ghostStarts[i].y, colors[i], waitingTime, difficulty));
      }
    }
  }
  
  void start(){    
    // Habe ich letztes mal vergessen
    WIDTH = map.WIDTH;
    HEIGHT = map.HEIGHT;
    windowResize(WIDTH * FIELD_SIZE, HEIGHT * FIELD_SIZE);
    
    numberOfPoints = map.numberOfPoints;
        
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
    
    ghosts = levelGhosts;
    for (Ghost ghost : levelGhosts) ghost.reset();
        
  }
  
}
