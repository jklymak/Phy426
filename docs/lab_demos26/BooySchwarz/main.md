%import packages
\documentclass[11pt]{article}
\usepackage{graphicx}
\usepackage{indentfirst}% Required for inserting images
\usepackage[
  a4paper,
  left=1.0in,
  right=1.0in,
  top=1.0in,
  bottom=1.0in
]{geometry}
\usepackage{amsmath}
\usepackage{lipsum,multicol,caption}
\usepackage{sectsty}
\usepackage{amssymb}
\usepackage{float}
\usepackage{url}

\renewcommand{\abstractname}{}
\DeclareMathOperator{\sech}{sech}

\begin{document}
\begin{center}
    {\LARGE \textbf{Gravity Waves}} \\[1em] 
    {Lukas Booy, Everett Schwarz} \\[0.5em] 
    {\itshape University of Victoria, Victoria, British Columbia, Canada} \\[0.5em] 
    Submitted April 6, 2026
\end{center}

\section*{Shallow Water Waves}

This experiment was designed to investigate wave propagation in shallow water flumes, resonance behavior in a large tidal tank, and particle paths using ink and different wave heights. Firstly, two small flumes of equal length ($l = 30.5 ~\rm cm$) were first filled to different water depths (2.5 cm and 4.6 cm) and one side of each was lifted to an equal height of 1.2 cm. The flumes were then released simultaneously to generate waves propagating back and forth along the channel.  When released, a timer was commenced to measure the time taken for ten complete reflections along the flume length, with an experimental wave speed measured to be:

$$c_{\rm exp} = \frac{10L}{t_{10}}$$

\noindent Where $L$ is the flume length and $t_{10}$ was the time for ten reflections. This was repeated for multiple heights, ascending from 2.5 cm to 3.4 cm for the first tank and descending from 4.6 cm to 3.4 cm for the second, and compared to the theoretical shallow water wave speed. 

\vspace{8pt}

Shallow water waves are defined as having a surface displacement much less than the weir depth, or $\eta \ll d$. Another way to define this limit is the wavelength being much greater than the water depth, $\lambda \gg d$. Using the governing equations of the flat-bottom case ($\partial_xd = 0$):

\begin{equation*}
    \rm{x-mom:} ~\partial_t u \approx -g \partial_x \eta, \quad~\rm{cont.:} ~\partial_t \eta \approx -d \partial_x u
\end{equation*}

\noindent combining these gives the wave equation:

\begin{equation*}
    \partial_{tt} \eta - gd \partial_{xx}\eta = 0
\end{equation*}

\noindent with a wavespeed 

\begin{equation*}
    c = c_g =c_p = \pm \sqrt{gd}
\end{equation*}

\vspace{8pt}

After the first experiment, with the different-depth flumes, the experimental propagation speed $c_{\exp}$ was compared to that of the depth-dependent theoretical value of $c_{\rm theo} = \sqrt{gd}$ The results are given in table 1 below, and visualized in figure 1.

\begin{table}[h!]
\centering
\begin{tabular}{|c|c|c|}
\hline
Depth [m] & $c_{\rm exp}$ [m/s] & $c_{\rm theo}$ [m/s] \\
\hline
0.025 & 0.449 & 0.495 \\
0.028 & 0.455 & 0.525 \\
0.031 & 0.484 & 0.551 \\
0.034 & 0.495 & 0.578 \\
0.034 & 0.502 & 0.578 \\
0.038 & 0.517 & 0.611 \\
0.042 & 0.537 & 0.642 \\
0.046 & 0.557 & 0.672 \\

\hline
\end{tabular}
\caption{\textit{Comparison of Experimental and Theoretical Velocities vs Depth}}
\label{tab:velocity_depth}
\end{table}

\begin{figure}
    \centering
    \includegraphics[width=0.8\linewidth]{shallow_flume.png}
    \caption{\textit{Comparison of theoretical and experimental shallow water wave speeds.}}
    \label{fig:placeholder}
\end{figure}

From the graph we can see that there is a non-linear loss of velocity between the theoretical and experimental values. The loss increases proportional to velocity and thus indicates the presence of bottom friction in the flume tank.

\section*{Resonant Frequencies}

Following the small flume experiments, attention was turned to the large tidal tank. The tank was filled to an initial depth of approximately 9 cm before the session to allow temperature and turbulent conditions to settle. A tidemaker (plunger) was set up near the end of the deep reservoir, and was powered by a voltage range of $6~V\to17~V$, increasing the angular speed of the plunger (set up shown in figure 2). During the tuning of the voltage, the repetitions per second and the corresponding amplitudes of each frequency were measured until there was no noticeable change in the amplitude difference. The depth of the tank was then set to 8 cm and finally 7 cm, and the procedure was repeated for these surface heights. 

\begin{figure}
    \centering
    \includegraphics[width=0.8\linewidth]{flume_tank.png}
    \caption{\textit{Tidal flume tank apparatus.}}
    \label{fig:placeholder}
\end{figure}

\vspace{8pt}

A rotating plunger, with rotational period $T$, generates waves/tides at a frequency of $f = 1/T$. The finite length of the tank supports the standing wave modes, the resonance of which occur every half wavelength: $\lambda_n = 2L/n, ~(n=1,2,3,...)$, or wavenumber $k_n = 2\pi /\lambda_n = n\pi /L$. Combining with the dispersion relation at the shallow water limit:

$$\omega_n^2 = gk_n \tanh(k_n d) \rightarrow \omega_n = \sqrt{gd} \cdot k_n$$

\noindent Therefore, each harmonic occurs at a frequency 

$$f_n = \frac{\omega_n}{2\pi} = \frac{n}{2L}\sqrt{gd}$$

\noindent If the forcing frequency matches a natural frequency, $f \approx f_n$, then resonance may occur. 

\vspace{3cm}

The frequency data collected for a range of voltages is displayed below for each of the depths, with the expected resonant frequency and corresponding voltage indicated by dashed/dotted lines.

\begin{figure}[H]
    \centering
    \includegraphics[width=0.55\textwidth]{freq_voltage.png}
    \caption{\textit{Angular frequency as a function of driving voltage for three water depths.}}
    \label{fig:freq_voltage}
\end{figure}

\vspace{2cm}

The amplitudes over a range of angular speed were plotted and fitted to a theoretical driven/damped harmonic oscillator function of the form:

$$A(\omega)= \frac{A_0}{\sqrt{(\omega-\omega_0)^2 + (2\gamma\omega)^2}}$$

\noindent With the results shown in Figure 4. 

\begin{figure}[H]
    \centering
    \includegraphics[width=0.55\textwidth]{resonance_curves.png}
    \caption{\textit{Resonance response curves for different water depths.}}
    \label{fig:resonance_curves}
\end{figure}

The results showed that both the resonant frequency and corresponding driving voltage increased with water depth, in agreement with the theoretical prediction of $f_n \propto \sqrt{d}$. The resonance curves are well described by a driven/damped harmonic oscillator model, with sinusoidal driving generated by the plunger mechanism and the overall damping caused by bottom friction and reflections off the apparatus walls. Discrepancies arise due to the limitations of the idealized harmonic oscillator model, which don't fully describe the molecular level interactions which fluids experience during boundary layer interactions.

\vspace{8pt}

Wave structure is a very important consideration for coastal and ocean engineering, since resonance can significantly increase the amplitude of surface waves in confined basins. In particular, harbors, inlets, and marinas may have increased wave activity when the incoming wave forcing has a frequency close to one of the basin's normal modes. Under these conditions, even a relatively small external disturbance can produce extremely large oscillations in both water level and current speeds. This can lead to destruction or damage to boats, increased strain on docks, and unsafe operating conditions for workers near said harbors. 

\vspace{8pt}

One example, seen below, is the Crescent City harbor (in California, USA), which has experienced tsunami conditions 31 times since a tide gauge was established in 1933 $^{[1]}$. This is due to the bathymetry of the sea floor surrounding the coastal city causing a focusing of tsunamis into the port via a ridge off the coast dubbed the Mendocino Fracture Zone $^{[1]}$. When the large waves hit deeper water, their speed increases and could have a chance of having a normal mode frequency of the harbor, causing the waves to increase even more in amplitude. 

\begin{figure}[H]
    \centering
    \includegraphics[width=1\textwidth]{crescent_city.jpeg}
    \caption{\textit{Crescent city: West Coast Tsunami Magnet $^{[2]}$}}
    \label{fig:crescent_city}
\end{figure}

\section*{Deep vs. Shallow Water Waves}

Finally, the deep water condition ($\lambda \gg d$ or $kd \gg 1$) was simulated by creating small wave packets by rapidly moving a paddle at the mouth of the tidal flume channel. This was done after injecting ink along a vertical profile to better visualize the particle paths at different water depths for different wave extremes. 

\vspace{8pt}

In the deep water limit, the dispersion relation becomes $\omega^2 = gk$ (because $\tanh (kd) \to 1$) and the phase and group speed are:

$$c_p = \frac{\omega}{k} = \sqrt{\frac{g}{k}} = \sqrt{\frac{g \lambda}{2\pi}}$$

$$c_g = \partial_k\omega = \frac12 \sqrt{\frac{g}{k}} = \frac12 c_p$$

\noindent Thus, when visualizing wave packets traveling in deep water, the waves will travel through the packet at approximately twice the speed of the group. This means that crests outrun the front of the packet and emerge from the back of the packet.

\vspace{8pt}

From Khundu \& Cohen (2008), waves are classified as \textit{deep-water waves} if the depth is only $28 \%$ more than the wavelength ($kd > 1.75$ or $d > 0.28\lambda$) $^{[3]}$. Particle orbits in such waves travel in ellipses with semiminor and semimajor axes nearly equal to $ae^{kz}$, or circles with a decay scale described by the particle excursion equations below (defined as $u = \partial_t \xi, ~w = \partial_t \zeta$):

$$\xi = -ae^{kz_0} \sin (kx_0 - \omega t), ~\zeta = ae^{kz_0} \cos(kx_0 - \omega t)$$

\noindent In the shallow water approximation ($kd \ll 1$), Khundu \& Cohen (2008) once again state that surface waves are \textit{shallow-water} if the water depth is less than 7\% of the wavelength ($d < 0.07 \lambda$) $^{[3]}$. In this regime, particle excursion equations become:

$$\xi = -\frac{a}{kd} \sin (kx - \omega t), ~\zeta = a\left(1+ \frac zd\right) \cos (kx - \omega t)$$

\noindent These are thin ellipses with a depth-independent semimajor axis and a linearly decreasing semiminor axis (zero at the bottom). 

The effects of simulated deep and shallow water waves were visualized using ink and different wave heights. Longer waves were observed to make the ink move uniformly, whereas shorter, higher amplitude waves moved the ink in large circles near the surface of the water and induced minimal movement near the bottom of the tank. Heat diffusion may have caused some extra movement since the water was not of perfectly uniform density. These effects were simulated below, with the ``shallow water'' particle paths drawn with red ellipses and the ``deep water'' with white circles.

\begin{figure}[H]
    \centering
    \includegraphics[width=1\textwidth]{particle_paths.jpg}
    \caption{\textit{Particle paths of both deep and shallow water simulated waves.}}
    \label{fig:crescent_city}
\end{figure}

\section*{For Next Time...}

- A long, constant depth wave tank would make for easier visualizations and differentiation between shallow and deep water characteristics.

\vspace{8pt}

- When placing ink on the bottom, allow for proper vertical diffusion for easy visualization of the particle excursions. 

\vspace{8pt}

- Put more effective reflection damping at the end of the tidal flume channel to minimize dispersive interference.

\vspace{8pt}

\section*{References}

[1] Dengler, L., Uslu, B., Barberopoulou, A., Borrero, J., \& Synolakis, C. (2008). The vulnerability of Crescent City, California, to tsunamis generated by earthquakes in the Kuril Islands region of the Northwestern Pacific. Seismological Research Letters, 79(5), 608–619. https://doi.org/10.1785/gssrl.79.5.608

\vspace{8pt}

[2] Dengler, L. (2025, August 9). Lori Dengler | When it comes to tsunamis, Crescent City is a special place. Times-Standard. \url{https://www.times-standard.com/2025/08/09/lori-dengler-when-it-comes-to-tsunamis-crescent-city-is-a-special-place/}

\vspace{8pt}

[3] Kundu, P. K., \& Cohen, I. M. (2010). Fluid Mechanics. Academic Press.

\end{document}