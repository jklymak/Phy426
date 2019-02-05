---
layout: default
title: Assignment/Reading 4, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Ch 7, sections 11 to 13 non-linear steepening waves, hydrualic jumps, solitons.  


### R1: Why do waves tend to steepen?  

Waves tend to steepen: why and why is the effecy greater in shallow water?

### R2: Jump condition

What two quantities are conserved across a hydraulic jump?

### R3: Solitary waves:

What two wave tendencies are balanced in a soliton?

## Assignment

 - Energy Conservation: Bernoulli Fcn
 - Shallow Water Equations
 - Hydraulic Control

### A1: Conservation of momentum in hydraulically controlled flow  (/20)

  Consider flow over an isolated obstacle in a channel, as in class.  Assume that the obstacle is a triangle, with height off a flat channel of $h_m = 10\ \mathrm{m}$, and that the triangle's ramp has a slope of 1/100.  Assume that the incoming two-d flow transport is a fixed $30\ \mathrm{m^2\,s^{-1}}$, that the flow is in steady state, and that the flow is controlled at the crest.

  - What is the thickness of the water column, $d_0$, far upstream of the obstacle?  (OK to use a root finder and give a numeric answer)
  - Knowing the height far upstream you can numerically integrate in x (or calculate the cubic at each point in x) to get the water thickness $d(x)$ as a function of $x$.  Plot the water thickness as a function of $x$ from $x=-1000 m$ (upstream) to $x=0\ \mathrm{m}$ (the crest).  Check that $F_m = 1$ in your calculation.  For precision, make sure that you have a data point every 10 cm or so; include your code, and the expressions you used to get the interface heights.  Make the plot as nice as possible (including the obstacle, helps.  
  -  Knowing the water thickness as a function of $x$, use the Momentum Theorem to numerically demonstrate that the momentum balance is satisfied.
