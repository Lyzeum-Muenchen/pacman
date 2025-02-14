class Map {
  
  ArrayList<Point> ghostStarts;
  Point playerStart;
  Point door;
  int WIDTH = 21;
  int HEIGHT = 21;
  boolean[][] walls = new boolean[WIDTH][HEIGHT];
  boolean[][] points = new boolean[WIDTH][HEIGHT];
  boolean[][] powerups = new boolean[WIDTH][HEIGHT];
  
  Map(){
    playerStart = new Point(2, HEIGHT - 2);
    
    generateBox(0,0,WIDTH,HEIGHT);
    generateBox(WIDTH/2-2, HEIGHT/2-1, 5, 3);
    
    for (int i = 0; i < 6; i++){
      generateBox(2 + i*3, 2, 2, 2);
      generateBox(2 + i*3, HEIGHT-4, 2, 2);
      generateBox(2, 2 + i*3, 2, 2);
      generateBox(WIDTH - 4, 2 + i*3, 2, 2);
    }
    generateBox(5, 8, 2, 2);
    generateBox(5, 11, 2, 2);
    generateBox(WIDTH-7, 8, 2, 2);
    generateBox(WIDTH-7, 11, 2, 2);
    
    generateBox(WIDTH/2, 5, 1, 3);
    generateBox(WIDTH/2, HEIGHT-8, 1, 3);
    generateBox(WIDTH/2-2, 6, 1, 3);
    generateBox(WIDTH/2+2, 6, 1, 3);
    generateBox(WIDTH/2-2, HEIGHT-9, 1, 3);
    generateBox(WIDTH/2+2, HEIGHT-9, 1, 3);
    
    walls[6][4] = true;
    walls[4][6] = true;
    walls[WIDTH-7][4] = true;
    walls[WIDTH-5][6] = true;
    walls[6][HEIGHT-5] = true;
    walls[4][HEIGHT-7] = true;
    walls[WIDTH-7][HEIGHT-5] = true;
    walls[WIDTH-5][HEIGHT-7] = true;
    
    walls[7][6] = true;
    walls[WIDTH-8][6] = true;
    walls[7][HEIGHT-7] = true;
    walls[WIDTH-8][HEIGHT-7] = true;
    
    walls[0][HEIGHT/2] = false;
    walls[WIDTH-1][HEIGHT/2] = false;
    
    walls[WIDTH-1][HEIGHT-2] = false;
      
    for (int i = 0; i < WIDTH; i++) {
      for (int j = 0; j < HEIGHT; j++) {
        if (! walls[i][j]) numberOfPoints ++;
        points[i][j] = true;
      }
    }
    for (int i = 0; i < 3; i++){
      points[WIDTH/2-1+i][HEIGHT/2] = false;
      numberOfPoints--;
    }
    
    door = new Point(WIDTH / 2, HEIGHT / 2 - 1);
    walls[door.x][door.y] = false;
    points[door.x][door.y] = false;
    
    powerups[1][1] = true;
    
    ghostStarts = new ArrayList();
    ghostStarts.add(new Point(WIDTH/2-1, HEIGHT/2)); // color(255,0,0), 5));
    ghostStarts.add(new Point(WIDTH/2+1, HEIGHT/2)); // color(0, 255, 255), 20));
  }
  
  void generateBox(int x, int y, int w, int h){
    for(int i = y; i < y+h; i++) {
      walls[x][i] = true;
      walls[x+w-1][i] = true;
    }
    for (int i = x; i < x+w; i++){
      walls[i][y] = true;
      walls[i][y+h-1] = true;
    }
  }
  
}
