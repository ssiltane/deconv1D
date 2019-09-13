% Point spread function used in the one-dimensional deconvolution example.
% The function differs from zero only in the interval [-a,a] with a
% positive constant a>0.The function  is defined by the formula
%
% (x + a)^2*(x - a)^2;
%
% This routine does not involve any normalization of the point spread
% function.
%
% Arguments:
% x   vector or matrix of evaluation points (real)
% a   positive constant, should satisfy 0<a<1/2 
%
% Jennifer Mueller and Samuli Siltanen, October 2012

function psf = PSF(x,a)

% Check that parameter a is in acceptable range
if (a<=0) | (a>=1/2)
    error('Parameter a should satisfy 0<a<1/2')
end

% Evaluate the polynomial
psf = (x + a).^2.*(x - a).^2;