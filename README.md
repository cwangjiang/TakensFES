# Delay-embedding Lorenz_example
This repository provide the source codes for conducting delay embedding of a time series from a dynamical system, conducting diffusion maps dimensionality reduction, and verifying the geometrical identification. Together with the code is the simple of Lorenz attractor, which can serve as the first example to verfify the validity of the codes.

## Lorenz attractor generation
Lorenz attractor is the 3 dimensional dynamical system generating from differential equation sets:
<p align="center">
	<img src="figures/Lorenz.gif" >
</p>
A 20k by 3 dimensional vector will be generated using `lorenz_generating.m` in matlab
```bash
[X] = lorenz_generating(28,10,8/3,[0 1 1.05],[0 100],0.000001)
```


<p align="center">
	<img src="example_Lorenz/Lorenz.png" width="600" height="400">
</p>
<p align="center">
	<em>Fig.1</em>
</p>

Refer to code provied by Moiseev Igor: https://www.mathworks.com/matlabcentral/fileexchange/30066-lorenz-attaractor-plot?focused=5176856&tab=function

### Subsampling Lorenz attractor

## Delay time and delay dimension
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
