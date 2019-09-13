% Use truncated SVD for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Jan 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn 
load data/SVD A U D V svals

% Number of singular values to use
r_alpha = 10; 

% Build the matrix Dplus
Dplus = zeros(size(D));
Dplus(1:r_alpha,1:r_alpha) = diag(1./svals(1:r_alpha));

% Compute reconstructions
rec    = V*Dplus*(U.')*mCF;
recn   = V*Dplus*(U.')*mCFn;

% Save results to disc
save data/deconv5 n xvec f mCF rec mCFn recn r_alpha

deconv5_truncSVD_plot

