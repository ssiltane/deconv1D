% Use Tikhonov regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Feb 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn 
load data/SVD A U D V svals

% Collection of regularization parameters
alphavec = 10.^linspace(-5,4,30);

% Construct the augmented measurement matrix
priormat = [zeros(n,1),eye(n)]-[eye(n),zeros(n,1)];
priormat = priormat(:,1:(end-1));
priormat(n,1) = 1;

% Construct augmented data vector
mtilde = [mCFn;zeros(n,1)];

% Loop over regularization parameters and compute reconstructions
sparsevec = zeros(size(alphavec));
recomat   = zeros(n,length(alphavec));
for iii = 1:length(alphavec)
    % Pick current regularization parameter
    alpha = alphavec(iii);

    % Compute reconstruction and record the result in the matrix recomat
    Atilde = [A;sqrt(alpha)*priormat];
    recn   = Atilde\mtilde;
    recomat(:,iii) = recn(:);
   
    % Monitor the run
    disp([iii length(alphavec)])
end

% Save results to disc
save data/tikhonov7b n alphavec xvec f mCFn recomat 

deconv7b_genTikhonov_many_plot

