class Ghost extends Actor {
  Ghost(int startX, int startY){
    super(startX, startY);
  }
  
  void draw(float displayX, float displayY, float t, float rotate){
    fill(255,0,0);
    rect((displayX + 0.1) * FIELD_SIZE, (displayY + 0.1) * FIELD_SIZE, 0.8*FIELD_SIZE, 0.8*FIELD_SIZE);
  }
}
