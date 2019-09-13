% Compute singular value decomposition of the convolution matrix A
% The routine deconv03_naive_comp.m must be computed before this one.
%
% Samuli Siltanen September 2019

% Load convolution matrix
load  data/deconv03 A 

% Compute singular value decomposition
[U,D,V] = svd(A);
svals   = diag(D);

% Save result to file
save data/SVD A U D V svals

deconv04_SVD_plot

