class Map {
  
  Point[] ghostStarts = new Point[4];
  Point playerStart;
  Point door;
  int WIDTH = 21;
  int HEIGHT = 21;
  boolean[][] walls = new boolean[WIDTH][HEIGHT];
  boolean[][] points = new boolean[WIDTH][HEIGHT];
  boolean[][] powerups = new boolean[WIDTH][HEIGHT];
  int totPoints;
  
  Map(String fileName){
    String[] lines = loadStrings(fileName);
    String[] size = lines[0].split(" ");
    WIDTH = int(size[0]);
    HEIGHT = int(size[1]);
    for (int i = 0; i < WIDTH; i++){
      for (int j = 0; j < HEIGHT; j++){
        char c = lines[j+1].charAt(i);
        switch(c){
          case 'X':
            walls[i][j] = true;
            break;
          case 'P':
            playerStart = new Point(i,j);
            break;
          case '-':
            door = new Point(i,j);
            break;
          case '1': 
          case '2':
          case '3':
          case '4':
            ghostStarts[c - '1'] = new Point(i,j);
            break;
          case '*':
            powerups[i][j] = true;
          case ' ':
            points[i][j] = true;
            totPoints ++;
        }
      }
    }
    
    
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
