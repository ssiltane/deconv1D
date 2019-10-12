% Try naive reconstruction
%
% Samuli Siltanen Sep 2019

% Choose signal 1 or 2
sig_num = 1;

% Load precomputed stuff
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2
if sig_num==1
    f = f1;
    mn = mn1;
else
    f = f2;
    mn = mn2;
end

% Let us build the measurement matrix using the ideal PSF
A = DC_convmtx(p,n);

% Construct measurement WITH inverse crime, for demonstration
mIC  = A*f(:);

% Naive inversions
recIC  = inv(A)*mIC(:);
recn   = inv(A)*mn(:);

% Save results to disc
save data/deconv03 A recIC recn mIC sig_num

deconv03_naive_plot

