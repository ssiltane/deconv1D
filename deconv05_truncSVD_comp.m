% Use truncated SVD for deconvolution
% The routines deconv02_discretedata_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Oct 2019

% Load previous results
load data/deconv02 n xvec Dx f tvec p pn mn
load data/SVD A U D V svals

% Number of singular values to use
r_alpha = 20; 

% Build the matrix Dplus
Dplus = zeros(size(D));
Dplus(1:r_alpha,1:r_alpha) = diag(1./svals(1:r_alpha));

% Compute reconstructions
recn   = V*Dplus*(U.')*mn(:);

% Save results to disc
save data/deconv05 n xvec f mn recn r_alpha

deconv05_truncSVD_plot

