---
layout: default
title: Assignment/Reading 8, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Boundary Layers
  - Instability

### R1: Growth of a boundary layer...

What parameters set how thick a boundary layer will be?  Consider a boat moving at 2 m/s (4 kts) through the water.  How thick will the boundary layer be 1 m back from the bow with this scaling?  

### R2: Instability:

From the reading, qualitatively describe how we determine if a wavelength is unstable in a flow.

## Assignment

  - Laminar flow

### A1: Shear Parallel Flow (/15)

Consider a flow between two parallel infinite plates a distance $H$ apart.  The upper plate is moving with speed $U$ parallel to the other plate, which is motionless.  The flow starts at rest and the plate is impulsively moved to speed $U$.  [Assume that the flow is laminar (i.e. no turbulence develops) and that the viscosity of the fluid is given by $\nu/(HU) = 0.1$.  Assume that there are no net pressure forces.]

 - What is the steady-state solution of the flow between the two plates (i.e. $u_0(z) \equiv u(z,t=\infty)$)
 - Derive a differential equation for the transient flow ($w(z,t) = u(z,t)-u_0(z)$) and state the spatial and temporal boundary conditions for $w(z,t)$.
 - Determine an appropriate form for the solution to $w(z,t)$ (Hint: The solution to $w$ is separable in time and space.  In order to match the initial condition, a discrete Fourier series in $z$ is required. )
 - Using a graphics software, plot the solution at time $t/(H^2/\nu) = 0.01,\  0.05,\ 0.2,\ 0.5,\ 1.,\ 10.$
 - argue that the rate of work by the upper plate is equal to the rate of viscous dissipation in the fluid
