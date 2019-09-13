% Use truncated SVD for deconvolution
% The routines deconv03_naive_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Sep 2019

% Load previous results
load data/deconv02 n xvec Dx f mn f1 mn1 
load data/SVD A U D V svals

% Number of singular values to use
r_alpha = 10; 

% Build the matrix Dplus
Dplus = zeros(size(D));
Dplus(1:r_alpha,1:r_alpha) = diag(1./svals(1:r_alpha));

% Compute reconstructions
recn   = V*Dplus*(U.')*mn(:);
recn1  = V*Dplus*(U.')*mn1(:);

% Save results to disc
save data/deconv05 n xvec f mn recn mn1 recn1 r_alpha

deconv05_truncSVD_plot

