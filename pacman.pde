final int WIDTH = 20;
final int HEIGHT = 9;
final int FIELD_SIZE = 40;

boolean[][] walls = new boolean[WIDTH][HEIGHT];

int timer = 0;
final int TICK = 2;
int ticks = 0;

Player p = new Player(10, 5);

void settings() {
  size(WIDTH * FIELD_SIZE, HEIGHT * FIELD_SIZE);
}


void setup(){
  for(int i = 0; i < HEIGHT; i++) {
    walls[0][i] = true;
    walls[WIDTH-1][i] = true;
  }
  for (int i = 0; i < WIDTH; i++){
    walls[i][0] = true;
    walls[i][HEIGHT-1] = true;
  }
  walls[0][HEIGHT/2] = false;
  walls[WIDTH-1][HEIGHT/2] = false;
}

void draw() {
  background(0);
  p.draw();
  
  noStroke();
  for (int i = 0; i < WIDTH; i++){
    for (int j = 0; j < HEIGHT; j++){
      fill(0,0,255);
      if (walls[i][j])
        rect(i*FIELD_SIZE, j*FIELD_SIZE, FIELD_SIZE, FIELD_SIZE);
    }
  }
  
  timer ++;
  if (timer >= TICK){
    timer = 0;
    ticks ++;
    
    p.move();    
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
