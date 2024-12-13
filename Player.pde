class Player extends Actor {
  
  int score = 0;

  Player(int startX, int startY){
    super(startX, startY);
  }
  
  void draw(float displayX, float displayY, float t, float rotate){
    fill(255, 255, 0);
    float angle = abs(t - 0.5) * 2 * PI / 4; // Werte von 0.0 bis PI / 4
    arc((displayX + 0.5) * FIELD_SIZE, (displayY + 0.5) * FIELD_SIZE, FIELD_SIZE, FIELD_SIZE, 
        PI + angle + rotate, 3 * PI - angle + rotate );
  }
  
  void move(){
    super.move();
    if(points[oldX][oldY]){
        points[oldX][oldY] = false;
        score ++;
    }
  }
}
