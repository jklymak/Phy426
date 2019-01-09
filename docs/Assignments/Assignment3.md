---
layout: default
title: Assignment/Reading 3, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Hydraulic control notes (To be forthcoming)
  - Waves Chapter 7: Read up until (and including) "Group Velocity and Wave
  Dispersion"

### R1: Why do wave crests move forward?  

 - sketch the orbitals in a surface wave after Figure 7.6, but include an orbital at the top crest of the wave, and one at the trough.  Do the convergences and divergences make the wave crest move forward?  How do you get waves going in the negative x direction using the same logic?

### R2: Dispersion relation:

Use a graphics package to quickly plot up the dispersion relation (7.40).  Indicate where the deep-water and shallow-water asymptotes are on your plot, and sketch (by hand if you like) the dispersion relations at the asymptotes.

### R3: Energetics of Waves

Why is 7.56 the only term in the energy equation for surface waves?  (see notes
from week 2/3 about energy equations...)


## Assignment

 - Kiniematics
 - Conservation of mass

### A1: Streamlines in a corner flow (/15)

The flow in a 90-degree bend at the origin can be described by

$$u = y$$

$$v = x$$

  - Derive and sketch the streamlines $\psi$ of the flow.
  - Contour the streamfunction on a computer
    - where in the flow would you put the walls to make this the flow in a corner?
  - Demonstrate analytically that the the flow is non-divergent (i.e. that the
    sum of the linear strain rates is zero)
  - Demonstrate that it is close to non-divergent in your computer code.  
  - put two material lines that are initially perpendicular to each other somewhere in the flow and advect them forward in time enough to see some distortion.  Show that their distortion is proportional to the shear strain rate you would calculate analytically.  (For the advection, I used a 2-d interpolation in scipy, which is a little funky (see below))

```python
    import scipy.interpolate as sinterp
    fu = sinterp.RectBivariateSpline(x, y, u.T)  # get the interpolant
    lineU = fu(line0x, line0y, grid=False)   # do the interpolation
```




### A2: Multiple density mixing vat (/5)

Suppose we have a mixing vat, with one inflow at $q_1 = 2\ m^3\,s^{-1}$ and a fluid of density $\rho_1 = 1000\ kg\,m^{-3}$, and a second inflow with density $\rho_2 = 1030\ kg\,m^{-3}$, and an outflow with density $\rho_3 = 1028\ kg\,m^{-3}$.  What must the outflow rate be if the fluids are incompressible?
