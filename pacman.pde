final int WIDTH = 20;
final int HEIGHT = 10;
final int FIELD_SIZE = 20;

boolean[][] walls = new boolean[WIDTH][HEIGHT];

int timer = 0;
final int TICK = 2;
int ticks = 0;

Player p = new Player(10, 5);

void setup(){
  size(400, 200);
  walls[3][4] = true;
}

void draw() {
  background(0);
  p.draw();
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
  if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT) {
    println(keyCode);
    p.direction = keyCode; 
  } 
}