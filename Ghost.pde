class Ghost extends Actor {
  Ghost(int startX, int startY){
    super(startX, startY);
  }
  
  void draw(float displayX, float displayY, float t, float rotate){
    fill(255,0,0);
    rect((displayX + 0.1) * FIELD_SIZE, (displayY + 0.1) * FIELD_SIZE, 0.8*FIELD_SIZE, 0.8*FIELD_SIZE);
  }
  
  int chooseDirection() {
    // Jeder Richtung wird eine Wahrscheinlichkeit zugeordnet
    float[] probabilities = new float[4];
    float sum = 0;
    ArrayList<Point> neighbours = new Point(x,y).getNeighbours();
    for (int i = 0; i < 4; i++){
      Point n = neighbours.get(i);
      if (p.distances[n.x][n.y] != -1){
        // Je naeher das Feld an Pacman, desto wahrscheinlicher
        probabilities[i] = 1. / (p.distances[n.x][n.y]+1);
        // Die Mathematik muesst ihr nicht genau verstehen
        // Wichtig ist: Diese Gewichtung sorgt dafuer, dass kuerzere Wege wahrscheinlicher genommen werden
        // Je hoeher der Exponent, desto besser ist der Geist im Verfolgen
        // Dies waere eine Moeglichkeit, den Schwierigkeitsgrad anzupassen
        probabilities[i] = pow(probabilities[i],3);
        sum += probabilities[i];
      }
    }
    
    // Geist darf nicht rueckwaerts laufen, es sei denn, er muss
    int backwards = (direction - LEFT + 2) % 4;
    if (sum > probabilities[backwards]) {
      sum -= probabilities[backwards];
      probabilities[backwards] = 0;
    }
        
    // nur ein bisschen Mathe, um mit den bestimmten Wahrscheinlichkeiten eine Richtung auszuwaehlen
    // Man kann sich vorstellen: wir teilen ein Intervall auf dem Zahlenstrahl entsprechend der Wahrscheinlichkeiten in Teilstuecke auf
    //    Dann ziehen wir eine zufaellige Zahl aus diesem Intervall und schauen, in welchem Teilstueck sie liegt
    float rand = random(sum);
    float cumulativeSum = 0;
    int i = 0;
    while (i < 4 && cumulativeSum < rand){
      cumulativeSum += probabilities[i];
      i++;
    }
    // Wie wir bereits wissen, ist UP == LEFT + 1, RIGHT == LEFT + 2 und DOWN == LEFT + 3
    return LEFT + i - 1;
  }
  
  void move(){
    if(ticks % ticksPerMove == 0){
      direction = chooseDirection();
      print(direction - LEFT);
    }
    
    super.move();
    
    int backwards = (direction - LEFT + 2) % 4 + LEFT;
    if (p.x == x && p.y == y){
      resetIn = p.ticksPerMove;
      println("Selbes Feld");
    } else if (backwards == p.direction && p.oldX == x && p.oldY == y) {
      resetIn = p.ticksPerMove / 4;
      println("Kollision");
    }
  }
}
