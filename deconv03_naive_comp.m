% Try naive reconstruction
%
% Samuli Siltanen Sep 2019

% Load precomputed stuff
load data/deconv02 n xvec Dx f tvec p pn mn

% Let us build the measurement matrix using the ideal PSF
A = DC_convmtx(p,n);

% Construct measurement WITH inverse crime, for demonstration
mIC  = A*f(:);

% Naive inversions
recIC  = inv(A)*mIC(:);
recn   = inv(A)*mn(:);

% Save results to disc
save data/deconv03 A recIC recn

deconv03_naive_plot

