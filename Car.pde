/*
 * Class for creating the moving car
 */

class Car implements Comparable {
  // positional field variables
  private float angle;
  private float initX;
  private float initY;
  private float initAngle;
  private float px;
  private float py;
  
  // car shape variables
  private static final int speed = 1;
  public static final float w = 10;
  public static final float h = 50/3;
  private Line front1;
  private Line front2;
  private Line back1;
  private Line back2;
  private Line lSide1;
  private Line lSide2;
  private Line rSide1;
  private Line rSide2;
  
  // create five directional lines that will be the "eyes" of the car
  private Line dir;
  private Line rDir;
  private Line lDir;
  private Line rDir1;
  private Line lDir1;
  
  // line mainly used to generate the lines that make up the car
  private Line perpDir;
  
  // neural network variables
  private NeuralNet brain;
  private float fitness;
  public boolean checked;
  
  // variable for controlling whether the car should move 
  private boolean moveVar;

  /*
   * Contructor
   * Inputs: x and y position of the car, angle and initial neural network
   */
  public Car(float px, float py, float angle, NeuralNet best) {
    initX = px;
    initY = py;
    initAngle = angle;
    this.px = px;
    this.py = py;
    this.angle = angle;
    
    // calculate all the neccessary lines that the consists of
    dir = new Line(px, py, angle, 200);
    lDir = new Line(px, py, angle - PI/4, 200);
    rDir = new Line(px, py, angle + PI/4, 200);
    lDir1 = new Line(px, py, angle - PI/8, 200);
    rDir1 = new Line(px, py, angle + PI/8, 200);
    perpDir = new Line(px, py, angle + 3*PI/2, 100);
    front1 = new Line(px + h/2, py, 3*PI/2, w/2);
    front2 = new Line(px + h/2, py, PI/2, w/2);
    back1 = new Line(px - h/2, py, 3*PI/2, w/2);
    back2 = new Line(px - h/2, py, PI/2, w/2);
    lSide1 = new Line(px, py - w/2, 0, h/2);
    lSide2 = new Line(px + h/2, py, PI/2, h/2);
    rSide1 = new Line(px - h/2, py, 0, h/2);
    rSide2 = new Line(px - h/2, py, PI/2, h/2);
    
    // choose whether the neural network will be new or not
    if (best == null) { 
      brain = new NeuralNet(5, 8, 2, 3);
    } else {
      brain = best;
    }
    moveVar = true;
    fitness = 0;
    checked = false;
  }
  
  /* 
   * Method for repositioning the car in the initial position
   */
  public void reset() {
    px = initX;
    py = initY;
    angle = initAngle;
  }

  /*
   * Method for better visualizing the car by placing a rectangle on top of it
   */
  public void show() {
    pushMatrix();
    drawCar();
    translate(px, this.py);
    rotate(angle + PI/2);
    stroke(255);
    fill(0, 255, 0);
    rect(0, 0, w, h);
    popMatrix();
    
    // Update all the directional lines car according to the way it is turning, if the car is still alive
    if (moveVar) {
      dir.updateAngle(angle);
      lDir.updateAngle(angle - PI/4);
      rDir.updateAngle(angle + PI/4);
      lDir1.updateAngle(angle - PI/8);
      rDir1.updateAngle(angle + PI/8);
      perpDir.updateAngle(angle + 3*PI/2);
      updateCar(h/2 + 1, w/2);
    }
  }

  /*
   * Method for updating the lines that the car consists of
   * Inputs: the distance of the center from the front and the side
   */
  private void updateCar(float distance1, float distance2) {
    if (moveVar) {
      front1.updateAngle(angle + 3*PI/2); 
      front1.updateIPoint(dir.getPx() + cos(dir.getAngle()) * (float) distance1, dir.getPy() + sin(dir.getAngle()) * (float) distance1);
  
      front2.updateAngle(angle + PI/2); 
      front2.updateIPoint(dir.getPx() + cos(dir.getAngle()) * (float) distance1, dir.getPy() + sin(dir.getAngle()) * (float) distance1);
  
      back1.updateAngle(angle + 3*PI/2); 
      back1.updateIPoint(dir.getPx() - cos(dir.getAngle()) * (float) distance1, dir.getPy() - sin(dir.getAngle()) * (float) distance1);
  
      back2.updateAngle(angle + PI/2); 
      back2.updateIPoint(dir.getPx() - cos(dir.getAngle()) * (float) distance1, dir.getPy() - sin(dir.getAngle()) * (float) distance1);
  
      lSide1.updateAngle(angle); 
      lSide1.updateIPoint(perpDir.getPx() + cos(perpDir.getAngle()) * (float) distance2, perpDir.getPy() + sin(perpDir.getAngle()) * (float) distance2);
  
      lSide2.updateAngle(angle + PI); 
      lSide2.updateIPoint(perpDir.getPx() + cos(perpDir.getAngle()) * (float) distance2, perpDir.getPy() + sin(perpDir.getAngle()) * (float) distance2);
  
      rSide1.updateAngle(angle); 
      rSide1.updateIPoint(perpDir.getPx() - cos(perpDir.getAngle()) * (float) distance2, perpDir.getPy() - sin(perpDir.getAngle()) * (float) distance2);
  
      rSide2.updateAngle(angle + PI); 
      rSide2.updateIPoint(perpDir.getPx() - cos(perpDir.getAngle()) * (float) distance2, perpDir.getPy() - sin(perpDir.getAngle()) * (float) distance2);
    }
  }
  
  /*
   * Getter method for getting the directional line of the car
   * Output: the directional line of the car
   */
  public Line getDir() {
    return dir;
  }
  
  /*
   * Method for drawing all the lines that the car consists of
   */
  private void drawCar() {
    stroke(255);
    strokeWeight(1);
    front1.show();
    front2.show();
    back1.show();
    back2.show();
    lSide1.show();
    lSide2.show();
    rSide1.show();
    rSide2.show();
    strokeWeight(1);
  }

  /*
   * Method for calculating the distance of a point (represented with a an array of length 2) from the center of the car
   * Input: the point/array
   * Output: the distance
   */
  private double distance(float[] point) {
    float dx = point[0] - px;
    float dy = point[1] - py;
    return Math.sqrt((dx * dx) + (dy * dy));
  }
  
  /*
   * Method for calculating the distance between a given point and the common point of a given line and the directional line of the car
   * Inputs: The point and the line
   * Output: the distance
   */
  private double distance(float[] point, Line other) {
    float[] otherPoint = dir.commonPoint(other);
    float dx = otherPoint[0] - point[0];
    float dy = otherPoint[1] - point[1];
    return Math.sqrt((dx * dx) + (dy * dy));
  }
  
  /*
   * Method for getting the prediction of the neural network
   * Input: the input array of the neural network
   * Output: the prediction array
   */
  public float[] predict(float[] input) {
    return brain.output(input);
  }
  
  /*
   * Method for checking whether a given line is in front of the car
   * Input: the line
   * Output: a boolean where true means that the line is in front of the car  
   */
  public boolean pointIsFront(Line other) {
    float[] frontPoint = dir.commonPoint(front1);
    float[] backPoint = dir.commonPoint(back1);
    return distance(frontPoint, other) < distance(backPoint, other);
  }
  
  /*
   * Method for checking whether the car is colliding with a line
   * Input: the line
   * Output: a boolean where true corresponds to the car colliding with the line
   */
  public boolean collide(Line other) {
    boolean frontB = (other.intersects(front1)) || (other.intersects(front2));
    boolean leftB = (other.intersects(lSide1)) || (other.intersects(lSide2));
    boolean rightB = (other.intersects(rSide1)) || (other.intersects(rSide2));
    return frontB || leftB || rightB;
  }
  
  /*
   * Method for checking whether the car is colliding with a given track
   * Input: the track
   * Output: a boolean where true corresponds to the car colliding with the track
   */
  public boolean collide(RaceTrack track) {
    boolean finalB = false;
    // loop through all the lines that make up the track and check if the car collides with any of them
    for (int i = 0; i < track.outerTrack.length; i++) {
      boolean frontB = (front1.intersects(track.outerTrack[i])) || (front2.intersects(track.outerTrack[i])) 
        || (front1.intersects(track.start)) || (front2.intersects(track.start));
      boolean leftB = (lSide1.intersects(track.outerTrack[i])) || (lSide2.intersects(track.outerTrack[i])) ||
        (lSide1.intersects(track.start)) || (lSide2.intersects(track.start));
      boolean rightB = (rSide1.intersects(track.outerTrack[i])) || (rSide2.intersects(track.outerTrack[i])) ||
        (lSide1.intersects(track.start)) || (lSide2.intersects(track.start));
      finalB = finalB || frontB || leftB || rightB;
    }

    for (int i = 0; i < track.innerTrack.length; i++) {
      boolean frontB = (front1.intersects(track.innerTrack[i])) || (front2.intersects(track.innerTrack[i]));
      boolean leftB = (lSide1.intersects(track.innerTrack[i])) || (lSide2.intersects(track.innerTrack[i]));
      boolean rightB = (rSide1.intersects(track.innerTrack[i])) || (rSide2.intersects(track.innerTrack[i]));
      finalB = finalB || frontB || leftB || rightB;
    }
    return finalB;
  }
  
  /*
   * Method used for changing the color of the rectangle used for visualizing the car to red
   */
  public void changeColor() {
    pushMatrix();
    translate(px, py);
    fill(255, 0, 0);
    rotate(angle + PI/2);
    rect(0, 0, w, h);
    popMatrix();
  }
  
  /* 
   * Method for stopping the car from moving
   */
  public void st() {
    moveVar = false;
  }
  
  /*
   * Method for updating the position and angle of the car and its consisting lines
   */
  public void move() {
    if (moveVar) {
      px += cos(angle) * speed;
      py += sin(angle) * speed;
      dir.updateIPoint(px, py);
      lDir.updateIPoint(px, py);
      rDir.updateIPoint(px, py);
      lDir1.updateIPoint(px, py);
      rDir1.updateIPoint(px, py);
      perpDir.updateIPoint(px, py);
    }
  }
  
  /*
   * Method for updating the fitness value of the car
   * Input: the amount to update the fitness by
   */
  public void updateFitness(float amt) {
    fitness += amt;
  }
  
  /*
   * Getter method for the fitness of the car
   * Output: the current fitness value
   */
  public float getFitness() {
    return fitness;
  }
  
  /*
   * Method for overriding the equals method
   * Input: some other car object
   */
  public boolean equals(Object other) {
    return other == this;
  }
  
  /*
   * Method for overriding the conparesTo method
   * Input: some other car object
   */
  public int compareTo(Object other) {
    if (other == this) {
      return 0;
    } else {
      return 1;
    }
  }
  
  /*
   * Getter method for the angle of the car
   * Output: the current angle
   */
  public float getAngle() {
    return angle;
  }
  
  /*
   * Getter method for the neural network of the car
   * Output: the current neural network
   */
  public NeuralNet getBrain() {
    return brain;
  }
  
  /*
   * Method for predicting the turn of the car through the neural network
   */
  public void turn() {
    // create the array variables for the input of the neural network of the car 
    float[] point = new float[2];
    float[] lPoint = new float[2];
    float[] rPoint = new float[2];
    float[] lPoint1 = new float[2];
    float[] rPoint1 = new float[2];
    
    // find the distance of the intersection of each directional line with the track 
    float distance;
    if (dir.intersects(track)) {
      point = dir.commonPoint(track);
      distance = (float) this.distance(point);
    } else {
      distance = 600;
    }

    float lDistance;
    if (lDir.intersects(track)) {
      lPoint = lDir.commonPoint(track);
      lDistance = (float) this.distance(lPoint);
    } else {
      lDistance = 600;
    }

    float rDistance;
    if (rDir.intersects(track)) {
      rPoint = rDir.commonPoint(track);
      rDistance = (float) this.distance(rPoint);
    } else {
      rDistance = 600;
    }

    float lDistance1;
    if (lDir1.intersects(track)) {
      lPoint1 = lDir1.commonPoint(track);
      lDistance1 = (float) this.distance(lPoint1);
    } else {
      lDistance1 = 600;
    }

    float rDistance1;
    if (rDir1.intersects(track)) {
      rPoint1 = rDir1.commonPoint(track);
      rDistance1 = (float) this.distance(rPoint1);
    } else {
      rDistance1 = 600;
    }
    
    // normalize the distances and feed them into the neural network 
    float[] input = new float[5];
    input[0] = distance/600;
    input[1] = lDistance/600;
    input[2] = rDistance/600;
    input[3] = lDistance1/600;
    input[4] = rDistance1/600;
    float[] output = this.predict(input);
    this.turn(output[0], output[1]);
  }
  
  /*
   * Helper method for actally turning the car
   * Inputs: the amount by which the car should turn and the direction
   */
  private void turn(float amt, float dir) {
    if (dir > 0.5) {
      angle -= amt;
    } else {
      angle += amt;
    }
  }
}
