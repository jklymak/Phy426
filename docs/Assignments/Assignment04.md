---
layout: default
title: Assignment/Reading 4, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Ch 7, sections 11 to 13 non-linear steepening waves, hydrualic jumps, solitons.


### R1: Why do waves tend to steepen?

Waves tend to steepen: why?

### R2: Jump condition

What two quantities are conserved across a hydraulic jump?

### R3: Solitary waves:

What two wave tendencies are balanced in a soliton?

## Assignment

 - Kiniematics
 - Conservation of mass

### A1: Streamlines in a corner flow (/15)

The flow in a 90-degree bend at the origin can be described by

$$u = y$$

$$v = x$$

  - Derive and sketch the streamlines $\psi$ of the flow.
  - Contour the streamfunction on a computer
    - where in the flow would you put the walls to make this a flow in a corner?
  - Demonstrate analytically that the the flow is non-divergent (i.e. that the
    sum of the linear strain rates is zero)
  - Demonstrate that it is close to non-divergent in your computer code.
  - put two material lines that are initially perpendicular to each other somewhere in the flow and numerically advect them forward in time enough to see some distortion.  Show that the rate that the elements come together or spread apart is close to the shear strain rate you would calculate analytically.  (For the advection, I used a 2-d interpolation in scipy, which is a little funky (see below))

```python
    import scipy.interpolate as sinterp
    fu = sinterp.RectBivariateSpline(x, y, u.T)  # get the interpolant
    lineU = fu(line0x, line0y, grid=False)   # do the interpolation
```


### A2: Multiple density mixing vat (/5)

Suppose we have a mixing vat, with one inflow at $q_1 = 2\ m^3\,s^{-1}$ and a fluid of density $\rho_1 = 1000\ kg\,m^{-3}$, and a second inflow with density $\rho_2 = 1030\ kg\,m^{-3}$, and an outflow with density $\rho_3 = 1028\ kg\,m^{-3}$.  What must the outflow rate be if the fluids are incompressible?
