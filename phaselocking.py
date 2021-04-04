# -*- coding: utf-8 -*-
"""
Created on Sun Apr  4 18:33:35 2021

@author: avitr
"""
#program to lock the phase locking of 2 sine waves
import numpy as np
import math
from matplotlib import pyplot as plt
import array as arr
f=50
w=2*np.pi*f
t=list()
t.append(0.0)
dt=0.1e-3
Ts=0.1e-3
toe=200e-3
h=Ts/toe
h1=w*Ts
h2 = Ts/2
alpha=(1-(h1*h1)/4)/(1+(h1*h1)/4)
beta=h1/(1+(h1*h1)/4)
kp=628
Ti=Ts*10
ki=0.5
om=list()
om.append(w)
h_output = Ts*om[0]
alpha_output = ((1-(h_output*h_output/4))/(1+(h_output*h_output/4)))
beta_output = (h_output/(1+(h_output*h_output/4)))
x=list()
x.append(0.0)
y=list()
y.append(1.0)
sinout=list() #op of harmonic oscillator
sinout.append(0.0)
cosout=list() #op of harmonic oscillator
cosout.append(1.0)
zcd1=list()
zcd1.append(1.0)
zcd2=list()
zcd2.append(1.0)
inp=list() #input to system cost(wt-120)
inp.append(1.0)
xor1=list()
xor1.append(0.0)
lpf1=list()
lpf1.append(1.0)
integr=list()

integr.append(1.0)

def XOR (a, b):
    if a != b:
        return 1
    else:
        return 0
    
def BIN (a):
    if a>0.0:
        return 1
    else:
        return 0
    
def ZCD(signal):
    if signal>=0.0 :
        return 1
    elif signal<0.0 :
        return 0
    
for n in range(0,50000) :
    t.append(1+t[n])
    x.append(alpha*x[n]+beta*y[n])
    y.append((-1)*beta*x[n]+alpha*y[n])
    sinout.append(alpha_output*sinout[n] + beta_output*cosout[n]) #bilinear harmonic oscillator implementation
    cosout.append((-1)*beta_output*sinout[n] + alpha_output*cosout[n])
    zcd1.append(y[n+1])
    zcd2.append(ZCD(sinout[n+1])) #feedback of sin output to zcd
    xor1.append(XOR(bool(BIN(zcd1[n+1])) , bool(BIN(zcd2[n+1])))) #Xor to find error
    lpf1.append(lpf1[n] + h*(xor1[n+1]-lpf1[n]))
    integr.append(integr[n]+h2*lpf1[n+1]+h2*lpf1[n])
    om.append(kp*lpf1[n+1] + ki*integr[n+1])
    h2_output = (Ts*om[n+1])
    alpha_output = ((1-(h2_output*h2_output/4))/(1+(h2_output*h2_output/4)))
    beta_output = (h2_output/(1+(h2_output*h2_output/4)))
plt.plot(t,y, 'g-', linewidth=1, label='y')
plt.plot(t,cosout, 'r-', linewidth=1, label='output')
plt.show()
plt.plot(sinout, 'g-', linewidth=1, label='y')
plt.plot(zcd2, 'r-', linewidth=1, label='zcd2')
plt.show()

plt.plot(zcd1, 'g-', linewidth=1, label='y')
plt.plot(zcd2, 'b-', linewidth=1, label='zcd2')
plt.plot(xor1, 'r-', linewidth=1, label='xor')
plt.show()

#here we can see omega i.e the difference between the 2 phases getting stable, phase locking at around 20000 samples
plt.plot(om, 'g-', linewidth=1, label='om')
plt.show()