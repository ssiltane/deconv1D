% Construct discrete Haar wavelet transform 
% as a matrix.
%
% Arguments:
% N        length of the signal
%
% Returns:
% Haarmat  transform matrix of size NxN
%
% Samuli Siltanen Dec 2014

function Haarmat = HaarTransformMatrix(N)

if mod(N,2)==1
    error('Argument N must be an even number')
end

% Build the Haar filters
LPfilt = [ 1 1]/sqrt(2);
HPfilt = [-1 1]/sqrt(2);

% Construct detail convolution part
tmp1   = convmtx(HPfilt,N);
tmp1   = tmp1(1:2:end,:);
tmp1   = tmp1(:,1:N);

% Construct averaging convolution part
tmp2   = convmtx(LPfilt,N);
tmp2   = tmp2(1:2:end,:);
tmp2   = tmp2(:,1:N);

% Combine the results
Haarmat = [tmp1;tmp2];

