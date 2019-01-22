---
layout: default
title: Assignment/Reading 4, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Ch 6: Irrotational (Ideal Fluid) Flow


## Assignment

  - Ideal Fluid

### A1: Numerical Potential Flow (/15)

The text describes an iterative procedure for solving for solving for
potential flow.  Consider a channel, 50 m wide, z=0 in the centre,
with a 2-D transport of $1\ \mathrm{m^2s^{-1}}$ in steady state.  Two
half cylinders are in the flow along the lower boundary, with their centers at (0.,-25) and radius 20 m, and (40,-25), radius 14 m.  

For all of these, please turn in your code.  I did this in Matlab and Python.

  - Solve, numerically, for the flow and plot 50 evenly-spaced streamlines (in streamline space).(HINTS: The code for this can be very short in a matrix language like matlab or numpy in Python.  You only need one for-loop to do the iterations on $\psi$. You need to set the lower boundary value of $\psi=0 \ \mathrm{m^2s^{-1}}$, and the upper boundary to $\psi=1\ \mathrm{m^2s^{-1}}$.)
  - Construct a solution with two doublets and calculate
    the streamlines from that, and \emph{quantitatively} compare with your fully numerical solution.  What is the major difference between the two solutions, and how would you  make your numerical solution more like the analytical? (HINTS, in class we did the analytical solution using cylindrical co-ordinates, but that is awkward here, where there are two doublets.  Instead, just form the complex flow potential $w(z)$ and contour the imaginary part.  Also note that the  values of $\psi$ are arbitrary to a constant, so you may want to set the lowest streamline's value to zero to compare with your numerical answer.)
