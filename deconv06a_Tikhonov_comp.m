% Use Tikhonov regularization for deconvolution.
%
% The routines deconv02_discretedata_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Sep 2020

% Choose signal 1 or 2 or 3
sig_num = 3;

% Regularization parameter
alpha = .001; 

% Load previous results
load data/SVD A U D V svals
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2 f3 m3 mn3
if sig_num==1
    f = f1;
    mn = mn1;
elseif sig_num==2
    f = f2;
    mn = mn2;
else
    f = f3;
    mn = mn3;
end

% Build the matrix Dplus_alpha
Dplus = zeros(size(D));
Dplus(1:n,1:n) = diag(svals./(svals.^2+alpha));

% Compute reconstruction
recn   = V*Dplus*(U.')*mn(:);

% Save results to disc
save data/tikhonov06 n xvec f mn recn alpha sig_num

% Plot the results
deconv06a_Tikhonov_plot

