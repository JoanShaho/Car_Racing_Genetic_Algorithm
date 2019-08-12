import java.util.*;

Car car;
//create a list of present and dead cars
List<Car> cars;
List<Car> deadCars;

//create the racetrack
RaceTrack track;

//create variables for size of window
public static float w = 600;
public static float h = 600;

float timeAlive;

//create a map for associating each car with its fitness 
Map<Float, Car> fitnesses;

//variable for best NN
NeuralNet bestBrain;

//variable used for debugging
boolean training = true;

//variables for controlling the lines killing the cars
boolean moveStart = true;
boolean moveSide = false;
int counter;

void setup() {
  size(600, 600);
  rectMode(CENTER);
  reset();
}

//initialize all the necessary vars
void reset() {
  counter = 0;
  timeAlive = 0;
  cars = generateCars(20, bestBrain);
  deadCars = new ArrayList<Car>();
  fitnesses = new TreeMap<Float, Car>();
  track = new RaceTrack();
  moveStart = true;
  moveSide = false;
}

void draw() {
  if (training) {
    for (int j = 0; j < 2; j++) {
      background(0);
      fill(255);
      timeAlive += 0.01;
      track.show();
      showCars(cars);
      moveCars(cars);
      turnCars(cars);
      if (moveStart) {
        // move the start line
        track.moveStart();
      }

      if (moveSide) {
        // move a side line
        track.moveSide();
      }
      
      // loop through all the cars to check if any of them hits the track or any of the elimination lines
      for (Car i : cars) {
        if (i.collide(track.finish)) {
          training = false;
          car = new Car(85, 550, 3*PI/2 + random(-0.05, 0.05), i.getBrain());
          i.updateFitness(10);
          fitnesses.put(i.getFitness(), i);
        } else if (i.collide(track) || (i.py > track.start.ipy && moveStart)|| (i.px < track.side.ipx && moveSide)) {
          if (!i.checked) {
            counter++;
            i.updateFitness(timeAlive);
            fitnesses.put(i.getFitness(), i);
            i.st();
            i.checked = true;
          }
        }
      }
      
      //stop moving the start line and move the side line
      if (track.start.ipy < 100) {
        moveStart = false;
        moveSide = true;
      }
      
      if (track.side.ipx > 280) {
        moveSide = false;
      }

      if (counter == 20 || timeAlive > 15) {
        bestBrain = pickBest(fitnesses);
        reset();
      }
      
      // use the moouse to restart the training process (mainly for debugging purposes)
      if (mousePressed) {
        mousePressed = false;
        bestBrain = pickBest(fitnesses);
        deadCars = new ArrayList<Car>();
        reset();
      }
    }
  } else {
  // show only the car hit the finish line 
    background(0);
    fill(255);
    new RaceTrack().show();
    car.show();
    car.move();
    car.turn();
    if (car.collide(track.finish)) {
      noLoop();
    }
  }
}
