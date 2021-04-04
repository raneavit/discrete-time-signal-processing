# -*- coding: utf-8 -*-
"""
Created on Sun Apr  4 15:17:02 2021

@author: avitr
"""
#simulation of rlc circuit to observe current and voltage of supply, resistor, capacitor
import matplotlib.pyplot as plt
import numpy as np
import math
Toe=10e-3
Ts=0.1e-3
f=50
w=2*(math.pi)*f
h=w*Ts
dt=0.1e-3
R=10
L=0.1
C=0.0001
t=list()
t.append(0.0)
x=list()
x.append(0.0)
y=list()
y.append(1.0)
vs=list()
vs.append(0.0)
vr=list()
vr.append(0.0)
vc=list()
vc.append(0.0)
i=list()
i.append(0.0)
vl=list()
vl.append(0.0)
for n in range(0,2000):
    t.append(1+t[n])
    x.append(x[n]+h*y[n])
    y.append(y[n]-h*x[n+1])
    i.append(i[n]+(Ts/L)*(vl[n]))
    vs.append(325*y[n])
    vr.append(R*i[n])
    vc.append(vc[n]+(Ts/C)*(i[n]))
    vl.append(vs[n+1]-vr[n+1]-vc[n+1])
plt.plot(t,vs, 'y-', label='Voltage')
plt.plot(t,i, 'r-', linewidth=1, label='Current')
plt.title('Supply Voltage & Current')
plt.xlabel('N')
plt.legend(fontsize='small')

plt.show(block=True)
plt.plot(t,vr, 'y-', label='Resistor Voltage')
plt.plot(t,i, 'r-', linewidth=1, label='Current')
plt.title('Resistor Voltage & Current')
plt.xlabel('N')
plt.legend(fontsize='small')
plt.show(block=True)
plt.plot(t,vc, 'y-', label='Capacitor Voltage')
plt.plot(t,i, 'r-', linewidth=1, label='Current')
plt.title('Capacitor Voltage & Current')
plt.xlabel('N')
plt.legend(fontsize='small')
plt.show(block=True)
plt.plot(vl, 'y-', label='Inductor Voltage')
plt.plot(i, 'r-', linewidth=1, label='Current')
plt.title('Inductor Voltage & Current')
plt.xlabel('N')
plt.legend(fontsize='small')
plt.show(block=True)