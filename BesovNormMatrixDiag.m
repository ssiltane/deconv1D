% Construct the Besov B111 norm multiplication matrix for one-dimensional
% wavelet transforms
%
% Arguments:
% n     length of signal, must be power of 2
%
% Returns
% d     vector of length n containing the appropriate weights
%
% Samuli Siltanen December 2014

function d = BesovNormMatrixDiag(n)

% Check that n is a power of two
if (log2(n)-floor(log2(n)))>0 
    error('Signal length n should be a power of two')
end

% Initialize diagonal of weight matrix B
d = ones(1,n);

% Loop over wavelet scales
index = 0;
N     = n/2;
for iii = 1:log2(n)
    jjj              = log2(n)-iii;
    d(index+[1:N])   = 2^(jjj/2);
    index            = index+N;
    N                = N/2;
end

