#harmonic oscillator hybrid method
import numpy as np
import math
from matplotlib import pyplot as plt
Toe=10e-3
Ts=0.1e-3
f=50
w=2*(math.pi)*f
h=w*Ts
dt=0.1e-3
t=list()
t.append(0.0)
x=list()
x.append(0.0)
y=list()
y.append(0.0)

a=list()
b=list()
c=list()
for n in range(0,4000) :
    t.append(1+t[n])
    #Harmonic Oscillator
    x.append(x[n]+h*y[n])
    y.append(y[n]-h*x[n+1])
    
plt.subplot(2, 1, 2)
plt.plot(x, 'b-', label='x = sin(wt)')
plt.plot(y, 'g-', linewidth=1, label='y = cos(wt)')
plt.xlabel('Time [sec]')
plt.grid()
plt.legend(fontsize='small')
plt.show(block=True)

#3 phases 120 degree apart using HO outputs
for n in range(0,4000) :
    a.append(y[n])
    b.append(-0.5*y[n]-0.866*x[n])
    c.append(-0.5*y[n]+0.866*x[n])
plt.subplot(2, 1, 2)
plt.plot(a, 'r-', linewidth=1, label='Phase A')
plt.plot(b, 'b-', label='Phase B')
plt.plot(c, 'g-', linewidth=1, label='Phase C')
plt.xlabel('Time [sec]')
plt.grid()
plt.legend(fontsize='small')
plt.show(block=True)
