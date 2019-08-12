/* 
 * This is a class for a racetrack
 */

class RaceTrack {
  // The array of outer lines 
  private Line[] outerTrack;
  
  // The array of inner lines
  private Line[] innerTrack;
  private float h = SmartCar.h;
  
  // The finish, start and side line
  private Line finish;
  public Line start;
  public Line side;
  
  private float size = 150;
  
  /*
   * Constructor, which contains an example of a racetrack 
   */
  public RaceTrack() {
    outerTrack = new Line[14];
    outerTrack[0] = new Line(10, h, 3*PI/2, 150);
    outerTrack[1] = new Line(outerTrack[0].getFPx(), outerTrack[0].getFPy(), -1.0, 100);
    outerTrack[2] = new Line(outerTrack[1].getFPx(), outerTrack[1].getFPy(), -2.0, 100);
    outerTrack[3] = new Line(outerTrack[2].getFPx(), outerTrack[2].getFPy(), 3*PI/2, 100);
    outerTrack[4] = new Line(outerTrack[3].getFPx(), outerTrack[3].getFPy(), -1.0, 100);
    outerTrack[5] = new Line(outerTrack[4].getFPx(), outerTrack[4].getFPy(), -0.5, 100);
    outerTrack[6] = new Line(outerTrack[5].getFPx(), outerTrack[5].getFPy(), -0.3, 100);
    outerTrack[7] = new Line(outerTrack[6].getFPx(), outerTrack[6].getFPy(), 0, 100);
    outerTrack[8] = new Line(outerTrack[7].getFPx(), outerTrack[7].getFPy(), 0.3, 100);
    outerTrack[9] = new Line(outerTrack[8].getFPx(), outerTrack[8].getFPy(), 0.5, 100);
    outerTrack[10] = new Line(outerTrack[9].getFPx(), outerTrack[9].getFPy(), 1.0, 100);
    outerTrack[11] = new Line(outerTrack[10].getFPx(), outerTrack[10].getFPy(), -3*PI/2, 100);
    outerTrack[12] = new Line(outerTrack[11].getFPx(), outerTrack[11].getFPy(), 2.0, 100);
    outerTrack[13] = new Line(outerTrack[12].getFPx(), outerTrack[12].getFPy(), PI/2, h - outerTrack[12].getFPy());
    
    innerTrack = new Line[14];
    innerTrack[0] = new Line(10 + size, h, 3*PI/2, 150);
    innerTrack[1] = new Line(innerTrack[0].getFPx(), innerTrack[0].getFPy(), -1.0, 100);
    innerTrack[2] = new Line(innerTrack[1].getFPx(), innerTrack[1].getFPy(), -2.0, 100);
    innerTrack[3] = new Line(innerTrack[2].getFPx(), innerTrack[2].getFPy(), 3*PI/2, 100);
    innerTrack[4] = new Line(innerTrack[3].getFPx(), innerTrack[3].getFPy(), -1.0, 100);
    innerTrack[5] = new Line(innerTrack[4].getFPx(), innerTrack[4].getFPy(), 0, 100);
    innerTrack[6] = new Line(innerTrack[5].getFPx(), innerTrack[5].getFPy(), 1.0, 1);
    innerTrack[7] = new Line(innerTrack[6].getFPx(), innerTrack[6].getFPy(), 0, 1);
    innerTrack[8] = new Line(innerTrack[7].getFPx(), innerTrack[7].getFPy(), 1.0, 100);
    innerTrack[9] = new Line(innerTrack[8].getFPx(), innerTrack[8].getFPy(), PI/2, 100);
    innerTrack[10] = new Line(innerTrack[9].getFPx(), innerTrack[9].getFPy(), 1.0, 100);
    innerTrack[11] = new Line(innerTrack[10].getFPx(), innerTrack[10].getFPy(), -3*PI/2, 100);
    innerTrack[12] = new Line(innerTrack[11].getFPx(), innerTrack[11].getFPy(), 2.0, 100);
    innerTrack[13] = new Line(innerTrack[12].getFPx(), innerTrack[12].getFPy(), PI/2, h - outerTrack[12].getFPy());
    
    this.finish = new Line(innerTrack[12].getFPx(), innerTrack[12].getFPy(), 0, 160);
    this.start = new Line(10, h - 10, 0, 170);
    this.side = new Line(0, 0, PI/2, 100);
  }
  
  /*
   * Getter method for the finish line of the racetrack
   * Output: the finish line
   */
  public Line getFinish() {
    return this.finish;
  }
  
  /*
   * Method for moving the start line upwards
   */
  public void moveStart() {
    this.start.ipy -= 1;
  }
  
  /*
   * Method for moving the side line to the right
   */
  public void moveSide() {
    side.ipx += 1.5;
  }
  
  /*
   * Method for visualizing the racetrack
   */
  public void show() {
    stroke(255);
    for (int i = 0; i < outerTrack.length; i++) {
      outerTrack[i].show();
    }
    
    for (int i = 0; i < innerTrack.length; i++) {
      innerTrack[i].show();
    }
    
    stroke(255, 255, 0);
    finish.show();
    start.show();
    side.show();
  }
}
