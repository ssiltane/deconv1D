% Use generalized (smoothness prior) Tikhonov regularization for 
% deconvolution.
%
% The routines deconv02_discretedata_comp.m and deconv03_naive_comp.m
% must be computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Sep 2022

% Choose signal 1 or 2 or 3 or 4
sig_num = 4;

% Regularization parameter
alpha = .1; 

% Load previous results
load data/SVD A U D V svals
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2 f3 m3 mn3 f4 m4 mn4
if sig_num==1
    f = f1;
    mn = mn1;
elseif sig_num==2
    f = f2;
    mn = mn2;
elseif sig_num==3
    f = f3;
    mn = mn3;
else
    f = f4;
    mn = mn4;
end

% Construct the augmented measurement matrix needed in the stacked-form
% computation of Tikhonov regularization
priormat = [zeros(n,1),eye(n)]-[eye(n),zeros(n,1)];
priormat = priormat(:,1:(end-1));
priormat(n,1) = 1;
Atilde   = [A;sqrt(alpha)*priormat];

% Construct augmented data vector
mtilde = [mn(:);zeros(n,1)];

% Compute reconstruction
recn   = Atilde\mtilde;

% Save results to disc
save data/tikhonov07a n xvec f mn recn alpha sig_num

deconv07a_genTikhonov_plot

