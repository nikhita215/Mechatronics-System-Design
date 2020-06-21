# Mechatronics_System_Design
## Physical system
<img src="/images/ipsystem.png" width="300">
This repository contains the simulink models of the swing-up and balancing controller designed for an inverted pendulum system. This system has a horizontal arm attached to a DC motor and a vertical arm attached at the end of the horizontal arm that can oscillate. Designing the controller for this system involved 3 stages. 

* First was modeling the dynamic system using first principles and performing experiments to identify various parameters of the system. 
* The second stage was designing the controllers in Matlab and simulating the dynamic system in Simulink by adding various kinds of non-linearities like Actuator saturation, Sensor quantization and Disturbance. 
* The final stage was real-time control implementation on actual hardware using Labview and MyRio. 

## Balancing controller
<img src="/images/balancing.png" width="700">
When the vertical equilibrium position is defined as θ = 0<sup>0</sup>, the balancing controller operates between θ = (-30<sup>0</sup>,+30<sup>0</sup>) and as the name suggests, it is responsible for maintaining the position of the pendulum at its unstable equilibrium. The balancing controller has a limited operating range because the dynamic equations of motion of the system were linearized about the vertical equilibrium and the linearization assumptions are only valid in the above range. The gains of the full-state feedback controller were determined using LQR function in MATLAB. The dynamic system was simulated by adding various non-linearities like sensor-quantization, disturbance and actuator saturation to check the robustness of the controller and modify the gains accordingly. 

## Swing-up controller
<img src="/images/swingup.png" width="900">
The swing-up controller is active when the angle of the pendulum θ < -35<sup>0</sup> or θ > +35<sup>0</sup>. A nonlinear model of the plant was used to simulate the system since the linearization assumptions are not valid anymore. This controller works on an energy based method and it is responsible for bringing to pendulum from θ = 180<sup>0</sup> when the system is at rest to vertical position for the balancing controller to take-over. The controller provides a gain to the system which is proportional to its energy (Kinetic+Potential). It is implemented in such a way that as the pendulum reaches the desired position the energy factor in the gain (E − E<sub>0</sub>) (where E<sub>0</sub> is the energy when θ = 0<sup>0</sup>) decreases and the controller provides lower and lower gains. A dead-zone of 5<sup>0</sup> was kept between the 2 controllers for safety so that both of them won't be active at the same time.

## Running the models
Run the Matlab script which contains various parameters for the Motor, Horizontal arm and Pendulum arm. You can also tune the LQR gains by modifying the Q and R matrices in the script. Then, you can run the simulink models for Balancing and Swing-up controllers. The equations of motion of the system used to generate the simulink models can be found in the pdf file. In the models, theta refers to the angle made by the horizontal arm and alpha refers to the angle made by the pedulum arm wrt the vertical position.

Results produced after combining the 2 controllers: 

<img src="/images/Horizontal_angle.jpg" width="450">  <img src="/images/Pendulum_angle.jpg" width="450">

While tuning the LQR gains less weightage is given to the postion of the horizontal arm, hence theta is not equal to 0 when the system is stabilized.
