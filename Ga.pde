/*
 * Library for implementing the genetic algorithm
 */

/*
 * Method for generating a certain number of cars with (or without) a certain neural network
 * Inputs: the number of cars to generate and a neural network object (which could be null)
 * Output: the generated list of cars
 */
public List<Car> generateCars(int num, NeuralNet best) {
  List<Car> cars = new ArrayList<Car>();
  for (int i = 0; i < num; i++) {
    cars.add(new Car(85, 550, 3*PI/2 + random(-0.05, 0.05), best));
  }
  return cars;
}

/*
 * Method for visualizing a given list of cars
 * Input: the list of cars
 */
public void showCars(List<Car> cars) {
  for (Car i : cars) {
    i.show();
  }
}

/*
 * Method for moving a given list of cars
 * Input: the list of cars
 */
public void moveCars(List<Car> cars) {
  for (Car i : cars) {
    i.move();
  }
}

/*
 * Method for turning a given list of cars
 * Input: the list of cars
 */
public void turnCars(List<Car> cars) {
  for (Car i : cars) {
    i.turn();
  }
}

/*
 * Method for normalizing the fitnesses of a given map of cars
 * Input: the mapping of the fitnesses to the corresponding cars
 * Output: the updated mapping
 */
public Map<Float, Car> normalizeFits(Map<Float, Car> fits) {
  float sum = 0;
  ArrayList<Float> temp = new ArrayList<Float>();
  
  // sum all the fitnesses
  for (float i : fits.keySet()) {
    sum += i;
    temp.add(i);
  }
  
  // add to the map the normalized fitnesses
  for (Float i : temp) {
    Car car = fits.get(i);
    fits.put(i/sum, car);
  }
  
  // remove the previous unnormalized fitnesses
  for (Float i : temp) {
    fits.remove(i);
  }
  return fits;
}

/*
 * Method for selecting the best car
 * Input: the mapping of the fitnesses to the corresponding cars
 * Output: the best car
 */
public NeuralNet pickBest(Map<Float, Car> fits) {
  float max = -2;
  NeuralNet best = null;
  
  // find the highest fitness value
  for (float i : fits.keySet()) {
    if (i > max) {
      max = i;
      best = fits.get(i).getBrain().clone();
      fitnesses.get(i).show();
    }
  }
  
  // mutate the selected car
  if (best != null) {
    best.mutate(0.01);
  }
  return best;
}
