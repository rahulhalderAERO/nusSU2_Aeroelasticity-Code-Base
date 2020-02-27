load 'GAF_4_Modes.mat';
dt = (pi/1800);
sys = ss(A,B,C,D,dt);
t = 0: (pi/1800):999*(pi/1800);
u1(1,:) = 1*sin(100*t);
y_aero = lsim(sys,u1,t);
plot(y_aero(1:1000,1),'r');
