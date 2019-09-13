% Use Tikhonov regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Feb 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn 
load data/SVD A U D V svals

% Regularization parameter
alpha = 10; 

% Build the matrix Dplus_alpha
Dplus = zeros(size(D));
Dplus(1:n,1:n) = diag(svals./(svals.^2+alpha));

% Compute reconstructions
rec    = V*Dplus*(U.')*mCF;
recn   = V*Dplus*(U.')*mCFn;

% Save results to disc
save data/tikhonov6 n alpha xvec f mCF rec mCFn recn 

deconv6_Tikhonov_plot

