class Level {
  Map map;
  ArrayList<Ghost> ghosts;
  final color[] colors = {#FF0000, #00FFFF, #00FF00, #FF00FF};
  
  Level(Map map, int nrGhosts, float difficulty){
    this.map = map;
    ghosts = new ArrayList();
    for (int i = 0; i < nrGhosts; i ++){
      ghosts.add(new Ghost(map.ghostStarts[i], colors[i], 5 + 10 * i, difficulty));
    }
  }
  
  void start(){
    pacman.this.ghosts = ghosts;
    for (Ghost ghost : ghosts) ghost.reset();
    WIDTH = map.WIDTH;
    HEIGHT = map.HEIGHT;
    windowResize(WIDTH * FIELD_SIZE, HEIGHT * FIELD_SIZE);
    doorX = map.door.x;
    doorY = map.door.y;
    p.startX = map.playerStart.x;
    p.startY = map.playerStart.y;
    p.reset();
    resetIn = -1;
    pointsLeft = map.totPoints;
    win = false;
    walls = new boolean[WIDTH][HEIGHT];
    points = new boolean[WIDTH][HEIGHT];
    powerups = new boolean[WIDTH][HEIGHT];
    for (int i = 0; i < WIDTH; i++){
      for (int j = 0; j < HEIGHT; j++){
        walls[i][j] = map.walls[i][j];
        points[i][j] = map.points[i][j];
        powerups[i][j] = map.powerups[i][j];
      }
    }
  }
}
