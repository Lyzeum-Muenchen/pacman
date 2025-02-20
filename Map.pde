class Map {
  int WIDTH, HEIGHT;
  boolean[][] walls;
  boolean[][] points;
  boolean[][] powerups;
  int numberOfPoints;
  int doorX, doorY;
  int playerX, playerY;
  Point[] ghostStarts = new Point[4];

  Map(String fileName) {
    String[] lines = loadStrings(fileName);
    String[] size = lines[0].split(" ");
    WIDTH = int(size[0]);
    HEIGHT = int(size[1]);

    walls = new boolean[WIDTH][HEIGHT];
    points = new boolean[WIDTH][HEIGHT];
    powerups = new boolean[WIDTH][HEIGHT];

    for (int i = 0; i < WIDTH; i++) {
      for (int j = 0; j < HEIGHT; j++) {
        switch(lines[j+1].charAt(i)) {
        case 'X':
          walls[i][j] = true;
          break;
        case '-':
          doorX = i;
          doorY = j;
          break;
        case 'P':
          playerX = i;
          playerY = j;
          break;
        case '1':
        case '2':
        case '3':
        case '4':
          ghostStarts[lines[j+1].charAt(i) - '1'] = new Point(i, j);
          break;
        case '*':
          powerups[i][j] = true;
        case ' ':
          points[i][j] = true;
          break;
        }
      }
    }
    p.reset();
  }
}
