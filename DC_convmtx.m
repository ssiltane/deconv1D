% Construct convolution matrix for the one-dimensional deconvolution example.
% We implement periodic boundary conditions.
%
% Arguments: 
% PSF   vector of odd lentgh M=2*m+1
% n     integer, must be n>=M; the size of the matrix will be (n x n)
%
% Returns:
% mtx   convolution matrix of size (n x n)
%
% Jennifer Mueller and Samuli Siltanen, October 2012

function mtx = DC_convmtx(PSF,n)

if mod(length(PSF),2)==0
    error('PSF must have an odd number of elements')
end

% Force PSF to be horizontal vector
PSF = PSF(:).';

% Determine the constant m (length of PSF should be 2*m+1)
m = (length(PSF)-1)/2;

% First: construct convolution matrix with the boundary condition assuming 
% zero signal outside the boundaries
tmp = convmtx(PSF,n);
mtx = tmp(:,(m+1):(end-m));

% Second: correct for the periodic boundary condition
for iii = 1:m
    mtx(1:m,(end-m+1):end) = tmp(1:m,1:m);
    mtx((end-m+1):end,1:m) = tmp((end-m+1):end,(end-m+1):end);
end




