% Construction of a target function to be reconstructed.
%
% Arguments:
% x  evaluation (real number)
%
% Returns
% res   value  f(x)
% 
% Samuli Siltanen Sep 2019

function res = convtarget1(x)

% Initialize as zero
res = zeros(size(x));

% Discontinuous spikes
index1 = (x>.2)&(x<.25);
res(index1) = 1;
index2 = (x>.28)&(x<.3);
res(index2) = 1.2;
index3 = (x>.35)&(x<.45);
res(index3) = .7;

% Smooth feature
index4 = (x>.6)&(x<.85);
res(index4) = sin(25*x(index4));