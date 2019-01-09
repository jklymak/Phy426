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

### A1: Tilting block (/10)

Consider a block of density $\rho$, with vertical height $L$, and widths in  
the other two directions of $d$ floating on top of a fluid of density $\rho_o$.

Demonstrate that the
block is stable to tipping if
$$ \left( \frac{d}{L}\right)^2 > 6 \left(\frac{\rho}{\rho_o}\right)\left(1-\frac{\rho}{\rho_o}\right)
$$

Some hints: Consider the torque about the centerline of the block at the water line.  I found this easiest to do by transforming the co-ordinate system so relative to the block so that the block is still vertical, but gravity and the water line are tilted, but either reference frame is fine.  Its best to consider two point sources, one pulling down at the center of mass and one pushing up at the center of buoyancy.  Please no results that depend on engineering formulas, unless you show the engineering formula.  
