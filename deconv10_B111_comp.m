% Example computations related to one-dimensional deconvolution.
% Demonstration of inversion by wavelet-based Besov space penalty.
%
% This routine needs Matlab's optimization toolbox.
%
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be
% computed before this one.
%
% Samuli Siltanen February 2015

% Regularization parameter
alpha = .0005;

% Load previous results
load data/deconv3 n xvec f A mCFn
data = mCFn(:);
n    = length(data);

% Construct wavelet transform matrix
if (log2(n)-floor(log2(n)))>0 % Check that n is a power of two
    error('Signal length should be a power of two')
end
W = eye(n);
for iii=1:log2(n)
    tmp = zeros(n);
    % Calculate the size of the convolution part of the matrix
    cN = n/(2^(iii-1));
    % Calculate the size of the unit block matrix
    uN = n-cN;
    % Construct the block matrix
    tmp(1:uN,1:uN) = eye(uN);
    tmp((end-cN+1):end,(end-cN+1):end) = HaarTransformMatrix(cN);
    % Update transform matrix
    W = tmp*W;
end

% Construct the diagonal weight matrix used in the Besov norm
B = diag(BesovNormMatrixDiag(n));
%B = eye(n);

% Construct input arguments for quadprog.m
H           = zeros(3*n);
H(1:n,1:n)  = 2*(W*A.')*(A*W.');
Aeq         = [B,-eye(n),eye(n)];
beq         = zeros(n,1);
lb          = [repmat(-Inf,n,1);zeros(2*n,1)];
ub          = repmat(Inf,3*n,1);
AA          = -eye(3*n);
AA(1:n,1:n) = zeros(n,n);
b           = [repmat(10,n,1);zeros(2*n,1)];
iniguess    = zeros(3*n,1);
f           = [-2*W*A.'*data; repmat(alpha,2*n,1)];

% Compute MAP estimate by constrained quadratic programming
% using alpha as regularization parameter
MAXITER = 400; % Maximum numbers of iterations (default value is 200)
MAXITER = 200; % Maximum numbers of iterations, Matlab's default value is 200
QPopt   = optimset('quadprog');
QPopt   = optimset(QPopt,'MaxIter', MAXITER,'Algorithm',...
    'interior-point-convex','Display','iter');
[uvv,val,ef,output] = quadprog(H,f,AA,b,Aeq,beq,lb,ub,iniguess,QPopt);
recn = W.'*uvv(1:n);

% Save results to file
save data/DC10_Besov111 recn W

% Plot results
deconv10_B111_plot