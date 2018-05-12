# Delay-embedding Lorenz_example
This repository provide the source codes in /src for conducting delay embedding of a time series from a dynamical system, conducting diffusion maps dimensionality reduction, and verifying the geometrical identification. Together with the code is the simple of Lorenz attractor in /example_Lorenz, which can serve as the first example to verfify the validity of the codes.

## Lorenz attractor generation
Lorenz attractor is the 3 dimensional dynamical system generating from differential equation sets:
<p align="center">
	<img src="figures/Lorenz.gif" >
</p>

A 20581 <img src="https://latex.codecogs.com/gif.latex?\times"> 3 dimensional vector will be generated using `lorenz_generating.m` in matlab

```bash
[X] = lorenz_generating(28,10,8/3,[0 1 1.05],[0 100],0.000001)

Lorenz_full = X
```

The Lorenz attractor is shown in Fig.1. Because 20581 points are slight too much, so we decide to evenly subsample 2000 points out from it, and generate a sparse version of the Lorenz attractor `Lorenz_sparse.mat`, we plot the full version `Lorenz_pull.mat` and the sparse version `Lorenz_sparse.mat` together as shown in Fig.1, these can be done using matlab script `Plot_dmap.m`:

```bash
Plot_dmap
```

<p align="center">
	<img src="example_Lorenz/Lorenz.png" width="600" height="400">
</p>
<p align="center">
	<em>Fig.1</em>
</p>

Refer to code provied by Moiseev Igor: https://www.mathworks.com/matlabcentral/fileexchange/30066-lorenz-attaractor-plot?focused=5176856&tab=function

## Delay time and delay dimension

We pretend to slect the x component from Lorenz attractor to perform delay embedding, when doing delay embedding, good delay time <img src="https://latex.codecogs.com/gif.latex?\tau"> and delay dimension D will be important, we use 'mutual information' (MI) to identify good delay time, and 'false nearest neighbour counting' to find good delay dimension. Good delay time can be the time at which MI drops to the first minima, applying `MI.m` to full version, we obtain the plot shown in Fig.2 top letf, which shows that <img src="https://latex.codecogs.com/gif.latex?\tau"> = 50 is a good delay time, but apply `MI.m` to the sparse version, it tells that <img src="https://latex.codecogs.com/gif.latex?\tau"> = 5 is a good delay time, as shown in the righ top panel in Fig.2, we will use <img src="https://latex.codecogs.com/gif.latex?\tau"> = 5.

<p align="center">
<img src="example_Lorenz/MI_full.png" width="400" height="300">
<img src="example_Lorenz/MI_sparse.png" width="400" height="300">
<img src="example_Lorenz/FNN.png" width="400" height="300">
</p>
<p align="center">
	<em>Fig.2</em>
</p>

For more about mutual information, refer to this article: DOI:https://doi.org/10.1103/PhysRevA.33.1134
and https://doi.org/10.1016/S0167-2789(97)00118-8 for nearest neighbor.

## Dimensionality reduction of Lorenz attractor
<p align="center">
<img src="example_Lorenz/Lorenz_spectrum.png" width="600" height="400">
<img src="example_Lorenz/Lorenz_dmap.png" width="600" height="400">
</p>
<p align="center">
	<em>Fig.3</em>
</p>

For more about diffusion maps, refer to these papers: https://doi.org/10.1073/pnas.0500334102
https://doi.org/10.1137/070696325

## Delay embedding of Lorenz attractor
<p align="center">
<img src="example_Lorenz/Lorenz_delayed.png" width="600" height="400">
</p>
<p align="center">
	<em>Fig.4</em>
</p>

Reference: https://doi.org/10.1016/0167-2789(86)90031-X

## Jacobian determinante
<p align="center">
<img src="example_Lorenz/Lorenz_detJ.png" width="600" height="400">
<img src="example_Lorenz/detJ_1D.png" width="600" height="400">
</p>
<p align="center">
	<em>Fig.5</em>
</p>
