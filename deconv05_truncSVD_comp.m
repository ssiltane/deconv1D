% Use truncated SVD for one-dimensional deconvolution.
%
% The routines deconv02_discretedata_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen September 2022

% Choose signal 
sig_num = 4;

% Number of singular values to use
r_alpha = 30; 

% Load previous results
load data/SVD A U D V svals
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2 f3 m3 mn3
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

% Build the matrix Dplus_alpha
Dplus = zeros(size(D));
Dplus(1:r_alpha,1:r_alpha) = diag(1./svals(1:r_alpha));

% Compute reconstructions
recn   = V*Dplus*(U.')*mn(:);

% Save results to disc
save data/deconv05 n xvec f mn recn r_alpha sig_num

deconv05_truncSVD_plot

