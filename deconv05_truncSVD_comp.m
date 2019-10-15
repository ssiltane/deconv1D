% Use truncated SVD for one-dimensional deconvolution.
%
% The routines deconv02_discretedata_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Oct 2019

% Choose signal 1 or 2
sig_num = 1;

% Number of singular values to use
r_alpha = 50; 

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

% Build the matrix Dplus
Dplus = zeros(size(D));
Dplus(1:r_alpha,1:r_alpha) = diag(1./svals(1:r_alpha));

% Compute reconstructions
recn   = V*Dplus*(U.')*mn(:);

% Save results to disc
save data/deconv05 n xvec f mn recn r_alpha sig_num

deconv05_truncSVD_plot

