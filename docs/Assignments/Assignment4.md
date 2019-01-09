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


### A1: Conservation of momentum in hydraulically controlled flow

  Consider flow over an isolated obstacle in a channel, as in class.  Assume that the obstacle is a triangle, with height off a flat channel of $h_m = 10\ \mathrm{m}$, and that the triangle's ramp has a slope of 1/100.  Assume that the incoming two-d flow transport is a fixed $30\ \mathrm{m^2\,s^{-1}}$, that the flow is in steady state, and that the flow is controlled at the crest.

  - What is the thickness of the water column, $d_0$, far upstream of the obstacle?  (OK to use a root finder and give a numeric answer)
  - Knowing the height far upstream you can numerically integrate in x (or calculate the cubic at each point in x) to get the water thickness $d(x)$ as a function of $x$.  Plot the water thickness as a function of $x$ from $x=-1000 m$ (upstream) to $x=0\ \mathrm{m}$ (the crest).  Check that $F_m = 1$ in your calculation.  For precision, make sure that you have a data point every 10 cm or so; include your code, and the expressions you used to get the interface heights.  Make the plot as nice as possible (including the obstacle, helps.  
  -  Knowing the water thickness as a function of $x$, use the Momentum Theorem to numerically demonstrate that the momentum balance is satisfied.
