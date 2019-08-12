/*
 * Class for a line
 */


class Line {
  // positional fields of the line
  private float ipx;
  private float ipy;
  private float fpx;
  private float fpy;
  
  // slope, y-intercept, length, and angle
  private float m; 
  private float b;
  private float l;
  private float angle;
  
 /*
  * Constructor
  * Inputs: first point of the line, angle, and length
  */
  public Line (float ipx, float ipy, float angle, float l) {
    this.ipx = ipx;
    this.ipy = ipy;
    this.fpx = ipx + cos(angle) * l;
    this.fpy = ipy + sin(angle) * l;
    this.angle = angle;
    this.m = tan(angle);
    this.b = this.ipy - (ipx * m);
    this.l = l;
  }
  
  /*
   * Method for updating the angle of the line
   * Input: the new angle of the line
   */
  public void updateAngle(float newAngle) {
    angle = newAngle;
    m = tan(angle);
    b = this.ipy - (ipx * m);
  }
  
  /*
   * Method for updating the first point of the line 
   * Input: the new x and y coordinates of the line
   */
  public void updateIPoint(float px, float py) {
    this.ipx = px;
    this.ipy = py;
    this.fpx = ipx + cos(angle) * l;
    this.fpy = ipy + sin(angle) * l;
  }
  
  /*
   * Method for checking whether a given point is within the limits of the line 
   * Input: the point (in the form of an array of length 2)
   */
  public boolean withinLimits(float[] point) {
    boolean x1Boolean = point[0] <= max(this.getFPx(), this.getPx()) + 5 && point[0] >= min(this.getFPx(), this.getPx()) - 5;
    boolean y1Boolean = point[1] <= max(this.getFPy(), this.getPy()) + 5 && point[1] >= min(this.getFPy(), this.getPy()) - 5;
    return x1Boolean && y1Boolean;
  }
  
  /*
   * Getter method for the angle of the line
   * Output: the current angle of the line
   */
  public float getAngle() {
    return angle;
  }
  
  /*
   * Method for calculating the y value of the line given the x value
   * Output: the y value
   */
  public float getY(float x) {
    return x * m + b;    
  }
  
  /*
   * Getter method for the slope of the line
   * Output: the current slope of the line
   */
  public float getM() {
    return m;
  }
  
  /*
   * Getter method for the y-intercept of the line
   * Output: the current y-intercept of the line
   */
  public float getB() {
    return b;
  }  
  
  /*
   * Method for checking whether the line intersects another line
   * Input: the other line
   * Output: the boolean where true means that the line is intersecting the other line
   */
  public boolean intersects(Line other) {
    float[] point = this.commonPoint(other);
    return (this.getM() != other.getM()) && this.withinLimits(point) && other.withinLimits(point); 
  }
  
  /*
   * Method for checking whether the line intersects a racetrack
   * Input: the racetrack
   * Output: the boolean where true means that the line is intersecting the racetrack
   */
  public boolean intersects(RaceTrack track) {
    boolean finalB = false;
    for (int i = 0; i < track.outerTrack.length; i++) {
      finalB = finalB || this.intersects(track.outerTrack[i]);;
    }
    
    for (int i = 0; i < track.innerTrack.length; i++) {
      finalB = finalB || this.intersects(track.innerTrack[i]);
    }
    return finalB;
  }
  
  /*
   * Getter method for the x value of the first point of the line
   * Output: the current x value of the first point of the line
   */
  public float getPx() {
    return ipx;
  }
  
  /*
   * Getter method for the y value of the first point of the line
   * Output: the current y value of the first point of the line
   */
  public float getPy() {
    return ipy;
  }
  
  /*
   * Getter method for the x value of the last point of the line
   * Output: the current x value of the last point of the line
   */
  public float getFPx() {
    this.fpx = ipx + cos(angle) * l;
    return fpx;
  }
  
  /*
   * Getter method for the y value of the last point of the line
   * Output: the current y value of the last point of the line
   */
  public float getFPy() {
    this.fpy = ipy + sin(angle) * l;
    return fpy;
  }
    
  /*
   * Method for finding the common point of this and another line
   * Input: The other line
   * Output: the common point (in the form of an array of length 2)
   */
  public float[] commonPoint(Line other) {
    float[] result = new float[2];
    result[0] = ((this.getB() - other.getB())/(other.getM() - this.getM()));
    result[1] = result[0]*this.getM() + this.getB(); 
    return result;
  }
  
  /*
   * Method for finding the common point of this line and a recetrack
   * Input: The racetrack
   * Output: the common point (in the form of an array of length 2)
   */
  public float[] commonPoint(RaceTrack track) {
    for (int i = 0; i < track.outerTrack.length; i++) {
      if (this.intersects(track.outerTrack[i])) {
        return this.commonPoint(track.outerTrack[i]);
      }
    }
    
    for (int i = 0; i < track.innerTrack.length; i++) {
      if (this.intersects(track.innerTrack[i])) {
        return this.commonPoint(track.innerTrack[i]);
      }
    }
    return new float[2];
  }
  
  /*
   * Method for visualizing the line
   */
  public void show() {
    line(ipx, this.ipy, ipx + cos(angle) * l, ipy + sin(angle) * l);
  }
}
