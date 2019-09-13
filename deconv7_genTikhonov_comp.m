% Use Tikhonov regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Feb 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn 
load data/SVD A U D V svals

% Regularization parameter
alpha = 1000; 

% Construct the augmented measurement matrix
priormat = [zeros(n,1),eye(n)]-[eye(n),zeros(n,1)];
priormat = priormat(:,1:(end-1));
priormat(n,1) = 1;
Atilde   = [A;sqrt(alpha)*priormat];


% Construct augmented data vector
mtilde = [mCFn;zeros(n,1)];

% Compute reconstruction
recn   = Atilde\mtilde;

% Save results to disc
save data/tikhonov7 n alpha xvec f mCFn recn 

deconv7_genTikhonov_plot

