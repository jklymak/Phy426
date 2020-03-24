---
layout: default
title: Assignment 11, Physics 426 Fluid Mechanics
---


## Assignment

### A1: Shear Instability in the presence of viscosity

1. Implement the calculation discussed in the notes for shear flow in a channel, with

```python
N=100
y = np.linspace(-10,10,N)*1e3
U = 0.15*(1.+np.tanh(-y/2.e3))
```

and numerically reproduce the curve for the growth timescale as a function of wavenumber shown in the notes.  

1. If there is no viscosity argue that Poiseuille Flow between two plates $2L$ apart is stable to inviscid shear instability, where $U(z) = U_0\left(1 - y^2/L^2\right)$.

2. Following the notes, argue that if we include viscosity, then we can write the perturbation equation
as
$$\left[\left( U(z)-c \right) \left(\frac{d^2}{dz^2} - k^2 \right) - U_{zz} +i\frac{\nu}{k}\left(\frac{d^4}{d z^4}-2k^2\frac{d^2}{dz} + k^4 \right)\right] \psi = 0 $$ where $u'=\partial \psi /\partial z$, and $w'=-\partial \psi / \partial x$.  Note that the boundary conditions are $\psi = \partial \psi / \partial z = 0$ at $y=\pm L$.  
This also can be solved as for the inviscid case, but its fourth order and a bit uglier!
