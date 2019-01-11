---
layout: default
title: Assignment/Reading 4, Physics 426 Fluid Mechanics
---


## Reading (Participation only, very short answer)

  - Sec 3.8, 3.11  
  - Ch 5, but skim 5.7


### R1: Simplifications due to vorticity equation

What variable drops out of the vorticity equation compared to the momentum equations.  Practically, can you think why dropping that term is useful?

### R2: Circulation

Sometimes we want to know the vorticity.  Why might it be easier to measure the circulation than the vorticity, and hence why would we calculate the circulation of a flow?  

### R3: Method of images

Vortext interactions with a wall can be modeled using the method of images.  What is the electrical equivalent?  

## Assignment

 - hydrostatic gravity waves
 - non-linear waves and bores

### A1: Standing wave in fjord (/15)

Consider a *hydrostatic* wave being forced at the mouth of a rectangular fjord of depth $H$ and length $L$. The sea-surface height at the mouth of the fjord is prescribed by the sea-surface height in the ocean $\eta(0,t) = \eta_O \cos (\omega t)$, where $\omega$ is the tidal frequency.

 - Derive an expression for the  the sea-surface height $\eta$ as a function of $x$ in the fjord assuming that there is no energy dissipation in the fjord.  Describe the response of sea-surface height at the head of the fjord as a function of the length of the fjord, $L$.  Also note that there are sometimes nulls in the response in the fjord.  Where are they?
 - What is the relationship between $u(x,t)$ and $\eta(x,t)$ in the fjord?  What happens to the velocity at the mouth as the fjord length approaches the resonant length?

### A2: Numerical characteristics steepening wave

Consider a steepening wave by computing characteristics.  Suppose there is a
quiescent region to the right of $x=0$ of thickness $d_0$ such that the shallow water wave speed there is $c=0.1 \ m/s$.  For $x<2.5\ m$ $c = 1 \ m/s$.  The wave speed varies linearly between these two points.  

We define $u$ such that the negative characteristic value is the same every where, i.e. $u(x, 0) = 2 (c(x, 0) - c(x>0, 0))$, so that the velocity is zero in the shallow region, and $1.8 \ m/s$ in the deep region, and linearly varying between the two regions.  
