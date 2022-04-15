% Use generalized Tikhonov regularization for deconvolution with the
% regularization parameter ranging over an interval with logarithmic
% sampling. 
%
% The routines deconv02_discretedata_comp.m and deconv03_naive_comp.m
% must be computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Sep 2020

% Choose signal 1 or 2 or 3
sig_num = 1;

% Collection of regularization parameters
alphavec = 10.^linspace(-6,4,40);

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

% Construct the prior matrix needed in the stacked-form
% computation of Tikhonov regularization
priormat = [zeros(n,1),eye(n)]-[eye(n),zeros(n,1)];
priormat = priormat(:,1:(end-1));
priormat(n,1) = 1;

% Construct augmented data vector
mtilde = [mn(:);zeros(n,1)];

% Loop over regularization parameters and compute reconstructions
recomat   = zeros(n,length(alphavec));
for iii = 1:length(alphavec)
    % Pick current regularization parameter
    alpha = alphavec(iii);
    
    % Construct the augmented measurement matrix
    Atilde   = [A;sqrt(alpha)*priormat];
    
    % Compute reconstruction
    recn   = Atilde\mtilde;
    
    % Record the result in the matrix recomat
    recomat(:,iii) = recn(:);
    
    % Monitor the run
    disp([iii length(alphavec)])
end

% Save results to disc
save data/gentikhonov07b n alphavec xvec f mn recomat sig_num

deconv07b_genTikhonov_many_plot

