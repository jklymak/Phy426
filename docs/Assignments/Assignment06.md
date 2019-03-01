---
layout: default
title: Assignment/Reading 4, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Ch 6: Irrotational (Ideal Fluid) Flow


### R1: Where is approx useful?

Under what conditions is it useful to assume the flow is irrotational?  What kind of flows would this be a bad assumption for?

### R2: Why does an irrotational flow around a circular cylinder exert no force?

If we push a rod through the water we will have to exert a force, despite the fact that irrotational flow theory says we won't. What two effects cause this resistance?  

### R3:  We will look at the conformal mapping ideas briefly.  

Why do the conformal mapping?  What advantage does applying these transformations give us?  

## Assignment

  - nonlinear waves and bores.
  - vorticity

### A1: Numerical characteristics steepening wave (/15)

Consider a steepening wave by computing the flow and height fields by the method of characteristics.  

Suppose there is a quiescent region to the right of $x=0$ of thickness $d_0$ such that the shallow water wave speed there is $c_0=0.1 \ m/s$.  For $x<-2.5\ m$ $c = 1 \ m/s$.  The wave speed varies linearly between these two points.  

We define $u$ such that the negative characteristic value is the same every where, i.e. $u(x, 0) = 2 (c(x, 0) - c_0)$, so that the velocity is zero in the shallow region, and $1.8 \ m/s$ in the deep region, and linearly varying between the two regions.  

 - Numerically compute $u(x, t)$ and $c(x,t)$ by implementing the algorithm discussed in class and plot the results.  Based on these plots, at what time does a shock form?
 - Numerically compute some positive and negative characteristics through this flow field and discuss how that leads to wave steepening.  Compare to the theoretical characteristic paths which all have a slope of
 $$ 1/(3 c(x, 0) - 2 c_0) $$  Note that if you have a disagreement with the numerical curves, you may need to make your x or t grids smaller.
