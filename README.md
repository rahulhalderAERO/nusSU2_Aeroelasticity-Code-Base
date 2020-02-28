# Implementation of the Modal Analysis Platform for the Aeroelastic Computation

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

1.	__SU2-5.0.0 codes :__ General SU2-5.0.0 codes downloaded from SU2 websites. Two folders namely SU2_CFD and Common are pulled here which include __src/solver_direct_mean.cpp__ and __src/grid_movement_structure.cpp__ respectively. These two .cpp files need to be modified with the updated .cpp files mentioned in the __Changed_Code_Random_Excitation__ and __Changed_Code_Sinusoidal_Excitation__ folders. 
2.	__Modified Codes :__ Two folders namely __Changed_Code_Random_Excitation__ and __Changed_Code_Sinusoidal_Excitation__ are dedicated for the demonstration of the code modification carried out in the present work. 
a) __*Changed_Code_Random_Excitation*__ folder includes the codes written for the random excitation of the wing in the modal directions. Here second mode excitation is shown for example.
a) __*Changed_Code_Sinusoidal_Excitation*__ folder includes the codes written for the sinusoidal excitation of the wing in the modal directions. Here first mode excitation is shown for example.
3.	__Linear&Nonlinear_Rom:__ The Python and MATLAB codes are written for the development of the linear and nonlinear reduced order model. __a.__ For Linear ROM : Run SUB_ID_MAIN.m first for the linear ROM development and then run INPUT_VAR.m. to vary the imput excitation. __Data used:__ *__GAF_4_Modes.mat__* __b.__ For Non-Linear ROM: Run Nonlinear_ROM.py , __Data used :__ *__Three_Dim.csv__* 
