#integrator solved with euler transform
import numpy as np
import math
from matplotlib import pyplot as plt
Toe=10e-3
Ts=0.1e-3
h=Ts/Toe
dt=0.1e-3
f=100
w=2*(math.pi)*f
t=list()
t.append(0.0)
u=list()
u.append(0.0)
v=list()
v.append(1.0)
x=list()
x.append(0.0)
y=list()
y.append(0.0)
for n in range(0, 4000):

    t.append(1+t[n])
    #Harmonic Oscillator
    u.append(u[n]+w*dt*v[n])
    v.append(v[n]-w*dt*u[n+1])
    x.append(10+u[n+1])
    #integrator
    y.append(y[n]+Ts*x[n])
plt.subplot(2, 1, 2)
plt.plot(x, 'b-', label='harmonic oscillator')
plt.plot(y, 'g-', linewidth=1, label='low pass filtered data')
#plt.plot(HP, 'r-', linewidth=1, label='hi pass filtered data')
plt.xlabel('Time [sec]')
plt.grid()
plt.legend(fontsize='small')
plt.show(block=True)
