% Use Tikhonov regularization for deconvolution
% The routines deconv02_discretedata_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Oct 2019

% Load previous results
load data/deconv02 n xvec Dx f tvec p pn mn
load data/SVD A U D V svals

% Regularization parameter
alpha = .01; 

% Build the matrix Dplus_alpha
Dplus = zeros(size(D));
Dplus(1:n,1:n) = diag(svals./(svals.^2+alpha));

% Compute reconstruction
recn   = V*Dplus*(U.')*mn(:);

% Save results to disc
save data/tikhonov06 n xvec f mn recn alpha

% Plot the results
deconv06_Tikhonov_plot

