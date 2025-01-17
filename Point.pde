class Point {
  int x, y;
  Point(int px, int py){
    x = px;
    y = py;
  }
  public ArrayList<Point> getNeighbours(){
    ArrayList<Point> neighbours = new ArrayList();
      
    neighbours.add(new Point ( (x+1)%WIDTH, y ));
    neighbours.add(new Point ( x, (y+1)%HEIGHT));
    neighbours.add(new Point ( (x-1+WIDTH) % WIDTH, y));
    neighbours.add(new Point ( x, (y-1+WIDTH) % HEIGHT));
    
    return neighbours;
  }
  
}
