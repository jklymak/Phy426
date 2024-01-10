---
layout: default
title: Assignment 2, Physics 426 Fluid Mechanics
---

## Reading (Participation only, very short answer)

- Chapter 2: This chapter is about Cartesian Tensors which are a very
important mathematical concept.  Hopefully you have seen before.  Skimming this chapter is useful, but our use of it will be peripheral in the course.
- Chapter 3: This material will be covered as we need it in the lectures
that follow.
- Chapter 4: Read most of this chapter:
  - conservation of mass (and the Boussinesq Approximation)
  - conservation of momentum
  - Bernoulli's Equation.
  - skim/skip thermodynamics.  Of course we love thermodynamics, but the
  practical applications are limited for most of fluid mechanics.

### R1:  Steady flow in channel

Imagine steady water flow down a rectangular channel that is 1-m wide.
For specificity, assume the water is 1 m deep.
  - Imagine dye is injected in the channel at four spots across the channel
  and sketch what the dye would trace out in time.
  - If there is no friction, and the water doesn't accelerate or decelerate,
  how much energy is need to keep it moving?
  - If there is friction, and the flow is still steady (i.e. the friction doesn't stop it), what force might be causing the water to keep moving down-
  channel?

### R2: Widening channel

Imagine the channel (gradually) widens to 2-m wide, but the flow remains
steady (in time); again assume *no friction*:
  - sketch what the dye streaks might look like as the channel widens.  Why did
  you choose these paths?
  - if you sketched your dye streaks properly, what do you thinks is conserved
  between them?
  - Assuming there is no friction, what forces are in the fluid that act to
  change the flow speed?

### R3:  Flow around a cylinder

Now imagine a very wide channel and a small cylinder placed in the flow so
that it looks like a circle from above; again assume steady flow and no
friction:
  - sketch how equally spaced dye streaks placed far upstream of the
  cylinder will deform around the cylinder.
  - what forces cause the deformation around the cylander?
  - change co-ordinate systems for a minute, and imagine the cylinder
  being pulled through the water.  What is the net rate of work (F*u)
  necessary to pull it through the water?


## Assignment (graded)

### A1: Conservation of momentum in hydraulically controlled flow  (/20)

  Consider flow over an isolated obstacle in a channel, as in class.  Assume that the obstacle is a triangle, with height off a flat channel of $h_m = 5\ \mathrm{m}$, and that the triangle's ramp has a slope of 1/100.  Assume that the incoming two-d flow transport is a fixed $10\ \mathrm{m^2\,s^{-1}}$, that the flow is in steady state, and that the flow is controlled at the crest.

  - What is the thickness of the water column, $d_0$, far upstream of the obstacle?  (Note that we cannot assume $u_0 = 0$ upstream of the obstacle, but otherwise the derivation is the same.  OK to use a root finder and give a numeric answer)
  - Knowing the height far upstream, you can numerically integrate in $x$ (or calculate the cubic at each point in $x$) to get the water thickness $d(x)$ as a function of $x$.  Plot the water thickness as a function of $x$ from $x=-1000 m$ (upstream) to $x=0\ \mathrm{m}$ (the crest).  Check that at the sill crest $\frac{u_m^2}{g d_m} = F_m = 1$ in your calculation.  For precision, make sure that you have a data point every 10 cm or so; include your code, and the expressions you used to get the interface heights.  Make the plot as nice as possible - including the obstacle, helps.
  -  Knowing the water thickness as a function of $x$, numerically demonstrate that the integrated momentum balance is satisfied in the x-direction over a volume that extends from upstream of the sill to the sill crest.  eg show that the momentum in versus the momentum out is balanced by the net forces on the water in the x-direction.

