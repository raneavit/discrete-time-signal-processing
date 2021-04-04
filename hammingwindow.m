% Design of FIR Filter Sampling technique/Windowing Method
clc;
clear;
close all;
% High pass filter design using a Hamming Window
Tau = 20 ;
M = 2*Tau + 1;
n = 0:1:Tau;
hd = zeros(1,Tau+1);
WH = zeros(1,Tau+1);

% Calculating hd(n)
for i=1:length(n)
   if n(i)-Tau==0
      hd(i) = 0.3;
   else
      hd(i) = (sin(0.4*pi*(n(i)-Tau)))/(pi*(n(i)-Tau));
end
end

% Plotting hd
hd_ = [hd,flip(hd(1:Tau))];
stem(hd_,'b','LineWidth',2);
ax = gca();
title('Plot of hd(n)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('Magnitude','FontSize',15);
set(ax,'xlim',[0 length(hd_)+1],'xtick',0:1:length(hd_)+1,'fontsize',15);
grid on;
figure();

% Calculating hamming window coefficients
for i=0:length(hd)-1
    WH(i+1) = 0.5 - 0.5*cos(2*pi*i/(M-1));
end

WH_ = [WH,flip(WH(1:Tau))];
stem(WH_,'r','LineWidth',2);
ax = gca();
title('Plot of Hanning Window','FontSize',15);
xlabel('n','FontSize',15);
ylabel('Magnitude','FontSize',15);
set(ax,'xlim',[0 length(WH_)+1],'xtick',0:1:length(WH_)+1,'fontsize',15);
grid on;
figure();

h = hd.*WH;
h_ = [h,flip(h(1:Tau))];
% Plotting h(n)
stem(h_,'g','LineWidth',2);
ax = gca();
title('Plot of h(n)','FontSize',15);
xlabel('n','FontSize',15);
ylabel('Magnitude','FontSize',15);
set(ax,'xlim',[0 length(h_)+1],'xtick',0:1:length(h_)+1,'fontsize',15);
grid on;
figure();

w = -pi:0.01:pi;
H = zeros(1,length(w));
phase_H = zeros(1,length(w));
for i=1:length(w)
    for j=1:length(h)
       if j==Tau+1
          H(i) = H(i) + h(j);
       else
          H(i) = H(i)+h(j)*cos(w(i)*(Tau-j+1))*2;
    end
    end

    if H(i)>0
       phase_H(i) = -Tau*w(i);
    else
       phase_H(i) = pi - Tau*w(i);
end
end

% Plotting the frequency response
plot(w,H,'r','linewidth',2);
grid on;
ax = gca();
title('Magnitude Response of Filter','FontSize',15);
xlabel('Frequency','FontSize',15);
ylabel('|H(w)|','FontSize',15);
set(ax,'xlim',[-pi pi],'xtick',-pi:pi/2:pi,'fontsize',15);
set(ax,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'});
figure();

% Plotting the phase response
plot(w,phase_H,'r','linewidth',2);
grid on;
ax = gca();
title('Phase Response of Filter','FontSize',15);
xlabel('Frequency','FontSize',15);
ylabel('\angleH(w)','FontSize',15);
set(ax,'xlim',[-pi pi],'xtick',-pi:pi/2:pi,'fontsize',15);
set(ax,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'});