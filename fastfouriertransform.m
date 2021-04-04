clc;
clear;
close all;

#function to find decimation in time FFT : Author of function - Soumya  Panda Copyright (c) 2015, Soumya Panda All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:
function X = DIT_FFT(x)
t = nextpow2(length(x)); 
j = [x zeros(1,(2^t)-length(x))] ;
j 
N = length(j); 
S = log2(N); 
j = bitrevorder(j); 
for stage=1:S 
a = 1; 
b = 1+2^(stage-1);
n=0;
while( n<=2^(stage-1)-1 && b<=N)
e = exp((-1i)*2*pi*n/(2^stage)); 
y = j(a)+e*j(b); 
z = j(a)-e*j(b);
j(a) = y;
j(b) = z;
a = a+1;
b = b+1; 
n = n+1;
if(rem(b,2^stage)== 1)
a = a+2^(stage-1); 
b = b+2^(stage-1);
n = 0;
end
end
end
X = j;
endfunction

#function to find decimation in frequency FFT : Author of Function - Soumya Panda
function X = DIF_FFT(x)
t = nextpow2(length(x));                       
j = [x zeros(1,(2^t)-length(x))] ;             
N = length(j);                                 
S = log2(N);                                   
for stage=S:-1:1
a = 1;
b = 1+2^(stage-1);                
n = 0;
while( n<=2^(stage-1)-1  && a<=N && b<=N)
l = (n).*(2^(S+1-stage))./2;
e = exp((-1i)*2*pi*l/(16));            
y = j(a)+j(b);
z = (j(a)-j(b)).*e;                 
j(a) = y;
j(b) = z;
a = a+1;                               
b = b+1;
n = n+1;
if (stage == 1)               
if(rem(1,a) == 1)            
a = a+2^(stage-1);
b = b+2^(stage-1);
n=0;
end
end
            
if(stage~=1)
if(rem(a,2^(stage-1))==1)
a = a+2^(stage-1);
b = b+2^(stage-1);
n = 0;
end
end
end
end                 
X = bitrevorder(j);
endfunction

%Four point sequence
x4=[3-2i, 1-1i, 2+1i, 1i];
N1=length(x4);
r=0:1:N1-1;
stem(r,abs(x4),'g','LineWidth',3);
ax = gca();
title('Plot of magnitude of x(n)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('|x|','FontSize',15);
set(ax,'xlim',[0 N1-1],'fontsize',15);
grid on;
figure();
stem(r,angle(x4),'b','LineWidth',3);
ax = gca();
title('Plot of phase of x(n)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('\angle x','FontSize',15);
set(ax,'xlim',[0 N1-1],'fontsize',15);
grid on;
figure();
disp("4-point Input Signal : ");
disp(x4);
X4 = DIT_FFT(x4);
disp("DIT FFT of x : ");
disp(X4);
stem(r,abs(X4),'g','LineWidth',3);
ax = gca();
title('Plot of magnitude of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('|x|','FontSize',15);
set(ax,'xlim',[0 N1-1],'fontsize',15);
grid on;
figure();
stem(r,angle(X4),'b','LineWidth',3);
ax = gca();
title('Plot of phase of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('\angle x','FontSize',15);
set(ax,'xlim',[0 N1-1],'fontsize',15);
grid on;
figure();
X_4 = DIF_FFT(x4);
disp("DIF FFT of x : ");
disp(X_4);
stem(r,abs(X_4),'g','LineWidth',3);
ax = gca();
title('Plot of magnitude of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('|x|','FontSize',15);
set(ax,'xlim',[0 N1-1],'fontsize',15);
grid on;
figure();
stem(r,angle(X_4),'b','LineWidth',3);
ax = gca();
title('Plot of phase of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('\angle x','FontSize',15);
set(ax,'xlim',[0 N1-1],'fontsize',15);
grid on;
figure();
x_4 = ifft(X4);
disp("IDIT FFT of X obtained : ");
disp(x_4);
x_4 = ifft(X_4);
disp("IDIF FFT of X obtained : ");
disp(x_4);
%Eight point sequence
x8=[1+0.707i,2,1-0.707i,2,0,1i,0,-1i];
N2=length(x8);
r=0:1:N2-1;
stem(r,abs(x8),'g','LineWidth',3);
ax = gca();
title('Plot of magnitude of x(n)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('|x|','FontSize',15);
set(ax,'xlim',[0 N2-1],'fontsize',15);
grid on;
figure();
stem(r,angle(x8),'b','LineWidth',3);
ax = gca();
title('Plot of phase of x(n)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('\angle x','FontSize',15);
set(ax,'xlim',[0 N2-1],'fontsize',15);
grid on;
figure();
disp("8-point Input Signal : ");
disp(x8);
X8 = DIT_FFT(x8);
disp("DIT FFT of x : ");
disp(X8);
stem(r,abs(X8),'g','LineWidth',3);
ax = gca();
title('Plot of magnitude of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('|x|','FontSize',15);
set(ax,'xlim',[0 N2-1],'fontsize',15);
grid on;
figure();
stem(r,angle(X8),'b','LineWidth',3);
ax = gca();
title('Plot of phase of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('\angle x','FontSize',15);
set(ax,'xlim',[0 N2-1],'fontsize',15);
grid on;
figure();
X_8 = DIF_FFT(x8);
disp("DIF FFT of x : ");
disp(X_8);
stem(r,abs(X_8),'g','LineWidth',3);
ax = gca();
title('Plot of magnitude of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('|x|','FontSize',15);
set(ax,'xlim',[0 N2-1],'fontsize',15);
grid on;
figure();
stem(r,angle(X_8),'b','LineWidth',3);
ax = gca();
title('Plot of phase of X(k)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('\angle x','FontSize',15);
set(ax,'xlim',[0 N2-1],'fontsize',15);
grid on;
figure();
x_8 = ifft(X8);
disp("IDIT FFT of X obtained : ");
disp(x_8);
x_8 = ifft(X_8);
disp("IDIF FFT of X obtained : ");
disp(x_8);