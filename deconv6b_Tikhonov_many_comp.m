% Use Tikhonov regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be
% computed before this one.
%
% Samuli Siltanen Feb 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn
load data/SVD A U D V svals

% Collection of regularization parameters
alphavec = 10.^linspace(-5,2,30);

% Loop over regularization parameters and compute reconstructions
sparsevec = zeros(size(alphavec));
recomat   = zeros(n,length(alphavec));
for iii = 1:length(alphavec)
    % Pick current regularization parameter
    alpha = alphavec(iii);
    
    % Build the matrix Dplus_alpha
    Dplus = zeros(size(D));
    Dplus(1:n,1:n) = diag(svals./(svals.^2+alpha));
    
    % Compute reconstruction and record the result in the matrix recomat
    recn = V*Dplus*(U.')*mCFn;
    recomat(:,iii) = recn(:);
    
    % Monitor the run
    disp([iii length(alphavec)])
end

% Save results to disc
save data/tikhonov6b n alphavec xvec f mCFn recomat

deconv6b_Tikhonov_many_plot

