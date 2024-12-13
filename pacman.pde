final int WIDTH = 21;
final int HEIGHT = 21;
final int FIELD_SIZE = 30;

boolean[][] walls = new boolean[WIDTH][HEIGHT];
boolean[][] points = new boolean[WIDTH][HEIGHT];
int numberOfPoints;

int timer = 0;
final int TICK = 2;
int ticks = 0;

Player p = new Player(1, 1);

ArrayList<Ghost> ghosts;

void settings() {
  size(WIDTH * FIELD_SIZE, HEIGHT * FIELD_SIZE);
}


void setup(){
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
  
  ghosts = new ArrayList();
  ghosts.add(new Ghost(1,HEIGHT-2));
}

void draw() {
  background(0);
  
  noStroke();
  for (int i = 0; i < WIDTH; i++){
    for (int j = 0; j < HEIGHT; j++){
      fill(200,150,75);
      if(points[i][j])
        ellipse((i+0.5)*FIELD_SIZE, (j+0.5)*FIELD_SIZE, 0.2 * FIELD_SIZE, 0.2*FIELD_SIZE);
      fill(0,0,255);
      if (walls[i][j])
        rect(i*FIELD_SIZE, j*FIELD_SIZE, FIELD_SIZE, FIELD_SIZE);
    }
  }
  
  for (Ghost ghost : ghosts){
    ghost.draw();
  }
  
  p.draw();
  
  fill(255);
  textAlign(LEFT,TOP);
  textSize(FIELD_SIZE*0.7);
  text("Score: " + p.score, FIELD_SIZE*0.15, FIELD_SIZE*0.15);

  
  timer ++;
  if (timer >= TICK){
    timer = 0;
    ticks ++;
    
    p.move();   
    for (Ghost ghost : ghosts){
      ghost.move();
    }
  }
}

void keyPressed(){
   println(keyCode);
  if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT) {
    p.direction = keyCode; 
  } else {
    switch(keyCode) {
      case 'w':
      case 'W':
        p.direction = UP;
        break;
      case 'a':
      case 'A':
        p.direction = LEFT;
        break;
      case 's':
      case 'S':
        p.direction = DOWN;
        break;
      case 'd':
      case 'D':
        p.direction = RIGHT;
        break;
    }
  }
  // w87
  // a 65
  // s 83
  // d 68
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
