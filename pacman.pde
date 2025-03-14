int WIDTH = 21;
int HEIGHT = 21;
final int FIELD_SIZE = 30;

boolean[][] walls;
boolean[][] points;
boolean[][] powerups;
boolean[][] glitches;

int numberOfPoints;
int doorX, doorY;

int timer = 0;
final int TICK = 2;
int ticks = 0;
int resetIn = -1;

final int POWERUP_DURATION = 300;

Player p = new Player(4, HEIGHT-2);

ArrayList<Ghost> ghosts = new ArrayList();

int level = 0;
ArrayList<Level> levels = new ArrayList();

void settings() {
  size(WIDTH * FIELD_SIZE, HEIGHT * FIELD_SIZE);
}


void setup(){
  String[] descriptions = loadStrings("levels.txt");
  for (String desc: descriptions){
    levels.add(new Level(desc));
  }
  levels.get(0).start();
}

void draw() {
  background(0);
  
  noStroke();
  
  randomSeed(ticks/10);
  for (int i = 0; i < WIDTH; i++){
    for (int j = 0; j < HEIGHT; j++){
      fill(#DEA185);
      if(points[i][j])
        ellipse((i+0.5)*FIELD_SIZE, (j+0.5)*FIELD_SIZE, 0.2 * FIELD_SIZE, 0.2*FIELD_SIZE);
      if(powerups[i][j])
        ellipse((i+0.5)*FIELD_SIZE, (j+0.5)*FIELD_SIZE, 0.4 * FIELD_SIZE, 0.4*FIELD_SIZE);
      fill(#1919A6);
      if (walls[i][j])
        rect(i*FIELD_SIZE, j*FIELD_SIZE, FIELD_SIZE, FIELD_SIZE);
      if (glitches[i][j]){
        colorMode(HSB,360,100,100);
        textAlign(CENTER, CENTER);
        textSize(FIELD_SIZE*0.9);
        fill((random(0,240)+300)%360, 99, 70);
        text((char) int(random(0,255)), (i+0.5)*FIELD_SIZE, (j+0.5)*FIELD_SIZE);
        colorMode(RGB,255,255,255);
      }
    }
  }
  
  strokeWeight(FIELD_SIZE * 0.16);
  stroke(200,150,75);
  noFill();
  rect((doorX + 0.08) * FIELD_SIZE, (doorY + 0.08) * FIELD_SIZE, FIELD_SIZE * 0.84, FIELD_SIZE * 0.84);
  noStroke();
  
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
    if (resetIn >= 0) resetIn --;
    if (resetIn == 0){
      p.die();
      resetAll();
    }
    
    
    p.move();   
    for (Ghost ghost : ghosts){
      ghost.move();
    }
  }
}

void keyPressed(){
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

void resetAll(){
  p.reset();
  for(Ghost ghost : ghosts){
    ghost.reset();
  }
}

void activatePowerup(){
  for (Ghost ghost : ghosts){
    ghost.direction = (ghost.direction - LEFT + 2) % 4 + LEFT;
    ghost.powerupTimer = POWERUP_DURATION;
    ghost.ticksPerMove = int(ghost.ticksPerMove / ghost.slowdown);
  }
}
