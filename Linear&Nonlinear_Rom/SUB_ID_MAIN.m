clear variables;
clc;
load 'GAF_4_Modes.mat';
% **************************************
%STEP 0 : Initial Data Read
% **************************************
%%%A B C D Matrix is organized in such a manner that : %%%%%%%%%%%%%%%%%%%%
%%% h/b : plunge is the first row alpha: pitch is the second row
%load 'sep_randII_Mach075SI09.mat'
%load 'check_data.mat'
i = 20;    
u = u_input(1:200,1);
y = Mode_4_Disp(1:200,1);
[l,ny] = size(y);if (ny < l);y = y';[l,ny] = size(y);end
if (i < 0);error('Number of block rows should be positive');end
if (l < 0);error('Need a non-empty output vector');end
[m,nu] = size(u);if (nu < m);u = u';[m,nu] = size(u);end
if (m < 0);error('Need a non-empty input vector');end
if (nu ~= ny);error('Number of data points different in input and output');end
if ((ny-2*i+1) < (2*l*i));error('Not enough data points');end
j = ny-2*i+1;
% **************************************
%STEP 1 : R Factorization
% **************************************
U = blkhank(u/sqrt(j),2*i,j); 		% Input block Hankel
Y = blkhank(y/sqrt(j),2*i,j); 		% Output block Hankel
R = triu(qr([U;Y]'))'; 		% R factor
R = R(1:2*i*(m+l),1:2*i*(m+l)); 	% Truncate
clear U Y
% **************************************
%STEP 2 : First Oblique Projection
% **************************************
mi2 = 2*m*i;
Rf = R((2*m+l)*i+1:2*(m+l)*i,:); 	% Future outputs
Rp = [R(1:m*i,:);R(2*m*i+1:(2*m+l)*i,:)]; % Past (inputs and) outputs
Ru  = R(m*i+1:2*m*i,1:mi2); 		% Future inputs
% Perpendicular Future outputs 
Rfp = [Rf(:,1:mi2) - (Rf(:,1:mi2)/Ru)*Ru,Rf(:,mi2+1:2*(m+l)*i)]; 
% Perpendicular Past
Rpp = [Rp(:,1:mi2) - (Rp(:,1:mi2)/Ru)*Ru,Rp(:,mi2+1:2*(m+l)*i)];
if (norm(Rpp(:,(2*m+l)*i-2*l:(2*m+l)*i),'fro')) < 1e-10
Ob  = (Rfp*pinv(Rpp')')*Rp; 	% Oblique projection
else
Ob = (Rfp/Rpp)*Rp;
end
% **************************************
%STEP 3:SVD of First Oblique Projection
% **************************************
[U3,S3,V3] = svd(Ob);
ss = diag(S3);
clear V3 S3 
n = rank(Ob);
U1 = U3(:,1:n); 	
% **************************************
%STEP 4:Forming Gamma 
% **************************************

% Determine gam and gamm
gam  = U1*diag(sqrt(ss(1:n)));
gamm = gam(1:l*(i-1),:);
% And their pseudo inverses
gam_inv  = pinv(gam);
gamm_inv = pinv(gamm);
clear gam gamm

% **************************************
%STEP 5: Forming Another Oblique Projection
% **************************************
Rf = R((2*m+l)*i+l+1:2*(m+l)*i,:); 	% Future outputs
Rp = [R(1:m*(i+1),:);R(2*m*i+1:(2*m+l)*i+l,:)]; % Past (inputs and) outputs
Ru  = R(m*i+m+1:2*m*i,1:mi2); 		% Future inputs
% Perpendicular Future outputs 
Rfp = [Rf(:,1:mi2) - (Rf(:,1:mi2)/Ru)*Ru,Rf(:,mi2+1:2*(m+l)*i)]; 
% Perpendicular Past
Rpp = [Rp(:,1:mi2) - (Rp(:,1:mi2)/Ru)*Ru,Rp(:,mi2+1:2*(m+l)*i)]; 
if (norm(Rpp(:,(2*m+l)*i-2*l:(2*m+l)*i),'fro')) < 1e-10
  Obm  = (Rfp*pinv(Rpp')')*Rp; 		% Oblique projection
else
  Obm = (Rfp/Rpp)*Rp;
end
% Determine the states Xi and Xip
Xi  = gam_inv  * Ob;
Xip = gamm_inv * Obm;
clear gam_inv gamm_inv Obm
%***************************************
%STEP 6 : Formation of System Matrices 
% **************************************
Rhs = [       Xi   ;  R(m*i+1:m*(i+1),:)]; %Right hand side
Lhs = [      Xip   ;  R((2*m+l)*i+1:(2*m+l)*i+l,:)]; %Left hand side

% Solve least squares
sol = Lhs/Rhs;
%Extract the system matrices
A = sol(1:n,1:n);
B = sol(1:n,n+1:n+m);
C = sol(n+1:n+l,1:n);
D = sol(n+1:n+l,n+1:n+m);
clearvars -except A B C D
% plot(eig(A),'o');