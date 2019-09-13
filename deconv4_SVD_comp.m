% Compute singular value decomposition of the convolution matrix A
% The routine deconv3_naive_comp.m must be computed before this one.
%
% Samuli Siltanen Jan 2015

% Load convolution matrix
load data/deconv3 n A 

% Compute singular value decomposition
[U,D,V] = svd(A);
svals   = diag(D);

% Save result to file
save data/SVD A U D V svals

deconv4_SVD_plot

