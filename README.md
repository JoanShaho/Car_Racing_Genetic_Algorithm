# Car_Racing_Genetic_Algorithm

This is an implementation of the Genetic Algorithm along with Neural Networks using a car racing simulation. The cars constantly move forward but the direction and amount that each one turns is determined by a neural network. 

- **Car**
    - The car consists of 8 lines (2 for each side). This was done to allow easier collision detection system since if the track intersects       any of those lines, the car has collided with the track. Additionall, a green rectangle is used to make the cars more visible.
    - There are 5 directional lines (2 left, 2 right, and 1 straight) through which the car "sees". The intersection of each of those lines       with the track are the car's vision.

- **RaceTrack **
    - The track where the cars are moving is modeled using a set of outer and inner lines which are all hardcoded. The reason for that was       to allow the user to create any track they want

- **Neural Network inputs and outputs**
    - The inputs of the neural network are the intersection points between the track and the five directional lines of the car. The outputs       are two: the first one determines the direction the car should turn and the second the angle.
    
- **Issues**
  1. Once the cars learn how to turn right at the first turn, it's difficult to make them learn to turn left, since they have learned that      turning left is the best option. The main reason for that is the lack of a large enough generation size (there are only 20 cars per        generation).
  2. Having more than 20 cars at once causes crashing and efficiency issues with the program.
  
- **Possible Solutions/Future changes**
  1. Try more complicated tracks.
  2. Add the number of directional lines for the cars.
  3. Try more complex Neural Networks
  3. Make the program less computationally expensive, thus allowing larger generations.
