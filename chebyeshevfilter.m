%chebyeshevfilter
clc;
close all;
clear all;

As = 0.2;
Ap = 0.707;
Ts = 1 ;
op = (pi)/2;
os = 3*pi/4;
N = 4 ;

%disp(a)
%directly entering roots for required chebyeshev filter design
c1 = [1, 1.168, 4.617, 3.217, 2.764]

a1=roots(c1)
disp(a1)
z=[0];
figure
zplane(z,a1)%pole zero plot in s domain
title('Pole-zero plot S-domain', "fontsize", 15)

disp('Transfer function in S-domain')
s=tf('s');
num1 = (1.95);
den1 = (s^4+1.168*s^3+4.617*s^2+3.217*s+2.764);
Hs = num1/den1
figure
bode(Hs)
title('Response in S-domain')

disp('Transfer function in Z-domain')
z = tf('z',1);
num2 = 1.95*(z+1)^4
den2 = 16*(z-1)^4 + 9.344*(z-1)^3*(z+1) + 18.468*(z-1)^2*(z+1)^2 + 6.434*(z-1)*(z+1)^3 + 2.764*(z+1)^4
Hz = num2/den2
c2 = [1.95, 7.8, 11.7, 7.8, 1.95]
c3 = [ 53.01, -58.76, 75.65, -47.12, 21.45]
p1 = roots(c3)
z1 = roots(c2)
figure
zplane(z1,p1);%pole zero plot in z domain
title('Pole-zero plot in Z-domain', "fontsize", 15)
disp(Hz)
figure
bode(Hz)
title('Response in Z-domain')
