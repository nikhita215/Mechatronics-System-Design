%% Horizontal Arm Parameters
clc
clear

g = 9.81; %m/s^2
L11 = 0.0051;  %meters
L1 = 0.2032;  %meters
% M1=0.911;  %kg
M1=0.312;  %kg
% I_bar_1_z1=0.0169; %kg -m^2 mass moment of inertia of arm about z axis (rotation axis) through its own CG 
I_bar_1_z1=0.00086;
Tf_theta=0.00228; %friction torque (N-m)
B_theta=3.5e-6; %3.7e-6 original viscous friction
%% Motor Parameters
Kb = 0.0822;  %back -emf constant (V -s/rad)
Kt = 0.0833;  %torque constant (N -m/A)
R_motor = 1.0435; %resistance (ohms)
L = 3.3E-3;   %inductance (H)
B_motor = 3.7e-6;
% B_motor = 9.7e-4 ; %viscous damping constant (N-m-s/rad)
Tf_motor = 0.0124; %Coulomb friction (N-m)
J = 4.1E-5;   %inertia (kg-m^2)
%% Pendulum Parameters
M2 = 0.0787; %kg
L21 = 0.083; %meters
I_bar_2_y2 = 9.31e-6; % kg-m^2
I_bar_2_x2 = 9.0257e-4;   % kg-m^2 4.0468e-4 better agreement
I_bar_2_z2 = 9.102e-4;   %kg-m^2
I_bar_2_x2y2 = 2.265e-5; %kg-m^2
Tf_phi=1.1e-4;    % friction torque (N-m)
B_phi= .5e-4;    %1e-4 original viscous friction (N-m-s/rad)
%% Complete system

C1 = M1*L11^2 + I_bar_1_z1 + M2*L1^2 + I_bar_2_y2;
C2 = M2*L1*L21 - I_bar_2_x2y2;
C3 = M2*L21^2 + I_bar_2_x2;
C4 = M2*9.81*L21;

A = [ 0 1 0 0;
    0 -B_theta*C3/(C1*C3 - C2^2) -C2*C4/(C1*C3 - C2^2) B_phi*C2/(C1*C3 - C2^2);
    0 0 0 1;
    0 B_theta*C2/(C1*C3 - C2^2) C1*C4/(C1*C3 - C2^2) -B_phi*C1/(C1*C3 - C2^2)];

B = [0;
    C3/(C1*C3 - C2^2);
    0;
    -C2/(C1*C3 - C2^2)];

C = eye(4);

D = zeros(4,1);

Q = [1 0 0 0;
    0 100 0 0;
    0 0 1000 0;
    0 0 0 1000];

R = 100000;

K = lqr(A,B,Q,R)

ini_cond = [0 0 pi/3 0]';

den_phi = [(C1*C3-C2^2) (B_phi*C1+B_theta*C3) (B_phi*B_theta-C1*C4) (-B_theta*C4) 0];
nem_phi = [-C2 0 0];
tf_phi = tf(nem_phi,den_phi);

%% Dynamic terms

t1 = I_bar_2_x2y2 - M2*L1*L21;
t2 = t1;
t3 = I_bar_2_z2 + M2*L21^2 - I_bar_2_y2;
td = M1*L11^2 + I_bar_1_z1 + M2*L1^2;