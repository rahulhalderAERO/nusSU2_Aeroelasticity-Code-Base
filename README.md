# Implementation of the Modal Analysis platform for the Aeroelastic Computation

## •	Major Requirements for the Modal Analysis Platform in Aeroelastic Computation

1.	The structural modes from the linear structural equation are first computed from a FEA solver (i.e. NASTRAN) . 
2.	White noise signal /Signal consisting of sinusoids of different amplitude and frequency  is generated is for the excitation of the   aerodynamic solver in all the computed structural modal direction. 

## •	Changes in the SU2 code structure:
1.	The structural deformation or movement is coded in grid_movement_structure.cpp. The function inside the code *__CSurfaceMovement::Surface_Pitching__* is modified to handle the modal displacement.
2.	The Pressure forces over the wing surface is coded in  solver_direct_mean.cpp. The function inside the code *__CEulerSolver::Pressure_Forces__* is modified to compute the generalized aerodynamic force. 
3.	Following figure shows the schematic of the implementation procedure to facilitate the modal displacements in SU2 environment. As demonstrated in the figure, *__the coefficients from the polynomial interpolation in MATLAB platform  are conveyed to the two separate sections in the SU2 code base__*,  namely as the grid movement solver and the solver which deals with the computation of the aerodynamic load for assuring generalized displacement and computation of the generalised aerodynamic forces, respectively.

<img width="495" alt="Implementation_Modal_Analysis_SU2" src="https://user-images.githubusercontent.com/46704607/75430769-c42d1500-5986-11ea-831d-7f8181531d51.PNG">
