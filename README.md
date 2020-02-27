# Implementation of the Modal Analysis platform for the Aeroelastic Computation

## •	Major Requirements for the Modal Analysis Platform in Aeroelastic Computation

1.	The structural modes from the linear structural equation are first computed from a FEA solver (i.e. NASTRAN) . 

<img width="415" alt="Structural_Modes" src="https://user-images.githubusercontent.com/46704607/75431462-d8bddd00-5987-11ea-8077-1b73fa009761.PNG">

2.	White noise signals /Signals consisting of sinusoids of different amplitude and frequency  are generated  for the excitation of the   aerodynamic solver in all the computed structural modal directions. 

## •	Changes in the SU2 code structure:
1.	The structural deformation or movement is coded in grid_movement_structure.cpp. The function inside the code *__CSurfaceMovement::Surface_Pitching__* is modified to handle the modal displacement.
2.	The Pressure forces over the wing surface is coded in  solver_direct_mean.cpp. The function inside the code *__CEulerSolver::Pressure_Forces__* is modified to compute the generalized aerodynamic force. 
3.	Following figure shows the schematic of the implementation procedure to facilitate the modal displacements in SU2 environment. As demonstrated in the figure, *__the coefficients from the polynomial interpolation in MATLAB platform  are conveyed to the two separate sections in the SU2 code base__*,  namely as the grid movement solver and the solver which deals with the computation of the aerodynamic load for assuring generalized displacement and computation of the generalised aerodynamic forces, respectively.

<img width="495" alt="Implementation_Modal_Analysis_SU2" src="https://user-images.githubusercontent.com/46704607/75430769-c42d1500-5986-11ea-831d-7f8181531d51.PNG">

Fifth order polynomial interpolation maps stuctural mesh designed in NASTRAN and fluid mesh in SU2 outlined in the following figure.

<img width="348" alt="Surface_Mesh_SU2_NASTRAN" src="https://user-images.githubusercontent.com/46704607/75432789-ee340680-5989-11ea-8809-1d17a4bcd219.PNG">

## •	Linear and Nonlinear Reduced Order Model 
Subspace Identification based linear reduced order model and Deep Learning based Nonlinear Reduced Order Model is computed using the structural interaction and generalized aerodynamic forces. The __MATLAB__ and *__Python__* based codes are included in the link. 

## •  Files included in the GitHub

1.	__SU2-5.0.0 codes :__ General SU2-5.0.0 codes downloaded from SU2 websites. 
2.	__Modified Codes :__ The codes that has been modified.
3.	__Python and MATLAB codes for the ROM development:__ The Python and MATLAB code written for the generation of the linear and nonlinear reduced order model. 
4.	__Structural Modes:__ The structural Modes from NASTRAN are computed.  
