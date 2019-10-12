% Use Tikhonov regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be
% computed before this one.
%
% Samuli Siltanen Oct 2019

% Choose signal 1 or 2
sig_num = 1;

% Load previous results
load data/SVD A U D V svals
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2
if sig_num==1
    f = f1;
    mn = mn1;
else
    f = f2;
    mn = mn2;
end

% Collection of regularization parameters
alphavec = 10.^linspace(-5.5,1.5,20);

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
    recn = V*Dplus*(U.')*mn(:);
    recomat(:,iii) = recn(:);
    
    % Monitor the run
    disp([iii length(alphavec)])
end

% Save results to disc
save data/tikhonov06b n alphavec xvec f mn recomat sig_num

deconv06b_Tikhonov_many_plot

