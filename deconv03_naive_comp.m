% Try naive reconstruction for the one-dimensional decomvolution problem,
% both with inverse-crime data and more realistic noisy data.
%
% The routine deconv02_discretedata_comp.m must be computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Sep 2020

% Choose signal 1 or 2 or 3
sig_num = 1;

% Load precomputed stuff
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

% Let us build the measurement matrix using the ideal PSF
A = DC_convmtx(p,n);

% Construct measurement WITH inverse crime, for demonstration
mIC  = A*f(:);

% Naive inversions
recIC  = inv(A)*mIC(:);
recn   = inv(A)*mn(:);

% Save results to disc
save data/deconv03 n xvec f mn A recIC recn mIC sig_num

deconv03_naive_plot

