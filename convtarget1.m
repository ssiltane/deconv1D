% Construction of a target function to be reconstructed.
%
% Arguments:
% x  evaluation (real number)
%
% Returns
% res   value  f(x)
% 
% Samuli Siltanen Oct 2019

function res = convtarget1(x)

% Initialize as zero
res = zeros(size(x));

% Discontinuous spikes
index1 = (x>.2)&(x<.25);
res(index1) = .4;
index2 = (x>.28)&(x<.3);
res(index2) = .95;
index3 = (x>.35)&(x<.45);
res(index3) = .7;

% Ramp feature
index4 = (x>.6)&(x<.85);
res(index4) = .6*x(index4);