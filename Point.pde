class Point {
  int x, y;
  Point(int px, int py){
    x = px;
    y = py;
  }
  
  // Gibt Nachbarn eines Punktes zurueck
  // Nun in der richtigen Reihenfolge: LEFT, UP, RIGHT, BOTTOM
  ArrayList<Point> getNeighbours(){
  
      ArrayList<Point> neighbours = new ArrayList();
      
      neighbours.add(new Point ( (x-1+WIDTH)%WIDTH, y ));
      neighbours.add(new Point ( x, (y-1+HEIGHT)%HEIGHT));
      neighbours.add(new Point ( (x+1) % WIDTH, y));
      neighbours.add(new Point ( x, (y+1) % HEIGHT));
      
      return neighbours;
      
  }
}
