# Mechatronics_System_Design
## Physical system
<img src="/images/ipsystem.png" width="300">
This repository contains the swing-up and balancing controller designed for an inverted pendulum system. This system has a horizontal arm attached to a DC motor and a vertical arm attached at the end of the horizontal arm that can oscillate. Designing the controller for this system involved 3 stages. 

* First was modeling the dynamic system using first principles and performing experiments to identify various parameters of the system. 
* The second stage was designing the controller using the control system toolbox in Matlab and simulating the dynamic system in Simulink by adding various kinds of non-linearities like Actuator saturation, Sensor quantization and Disturbance. 
* The final stage was real-time control implementation on actual hardware using Labview and MyRio. 

## Balancing controller
<img src="/images/balancing.png" width="700">
The gains of the full-state feedback controller were determined using LQR function in MATLAB. The dynamic system was simulated by adding various non-linearities like sensor-quantization, disturbance and actuator saturation to check the robustness of the controller and modify the gains accordingly. When the vertical equilibrium position is defined as θ = 0<sup>0</sup>, The balancing controller operates between θ = (-30<sup>0</sup>,+30<sup>0</sup>). The balancing controller has a limited operating range because the dynamic equations of motion of the system were linearized about the vertical equilibrium and the linearization assumptions are only valid in the above range. 

## Swing-up controller
<img src="/images/swingup.png" width="700">
The swing-up controller is active when the angle of the pendulum θ < -35<sup>0</sup> or θ > +35<sup>0</sup>. This controller works on an energy based method. The controller provides a gain to the system which is proportional to its energy(Kinetic+Potential). It is implemented in such a way that as the pendulum reaches the desired position the energy factor in the gain (E − E<sub>0</sub>)(where E<sub>0</sub> is the energy when θ = 0<sup>0</sup>) decreases and the controller provides lower and lower gains. A dead-zone of 5<sup>0</sup> was kept between the 2 controllers for safety so that both of them won't be active at the same time.
