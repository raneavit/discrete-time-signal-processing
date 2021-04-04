%butterworth filter
clc;
close all;
clear all;

As = 0.2;
Ap = 0.707;
Ts = 1 ;
op = (pi)/2;
os = 3*pi/4;
Op = (2/Ts)*tan(op/2)
Os = (2/Ts)*tan(os/2)

num = log(((1/As^2)-1)/((1/Ap^2)-1));
disp(num);
den = log(Os/Op);
disp(den);

%finding order of filter
N1 = 0.5*num/den;
disp(N1)
%round up
N = ceil(N1);
disp(N)
oc = Op/(((1/Ap^2)-1)^(1/(2*N)))
a = zeros(1,(2*N));

%roots for tf of butterworth
for k=1:N
    a(k) = oc*exp((j*(N+(k*2)+1)*pi)/(2*N));
    a(2*N-k+1) = oc*exp((-j*(N+(k*2)+1)*pi)/(2*N));
end
%disp(a)
a1=a.';
disp(a1)
z=[0];
figure
zplane(z,a1)%pole zero plot in s domain
title('Pole-zero plot S domain', "fontsize", 15)

disp('Transfer function in S-domain')
disp(oc^N)
s=tf('s');
Hs = (oc^N)/(s^2+2.828*s+4)
figure
bode(Hs)
title('Response in S-domain')

disp('Transfer function in Z-domain')
z = tf('z',1);
Hz = ((4*(z^2+2*z+1))/(13.656*z^2+2.344))
num1 = [4, 8, 4];
p1 = roots(num1)
den1 = [13.656, 0, 2.344]
z1 = roots(den1)
figure
zplane(z1,p1);%pole zero plot in z domain
title('Pole-zero plot Z-domain', "fontsize", 15)
disp(Hz)
figure
bode(Hz)
title('Response in Z-domain')
