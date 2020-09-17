% Example computations related to one-dimensional deconvolution.
% Demonstration of inversion by wavelet-based Besov space penalty.
%
% The routines deconv02_discretedata_comp.m and deconv03_naive_comp.m
% must be computed before this one.
%
% Samuli Siltanen Sep 2020

% Choose signal 1 or 2 or 3
sig_num = 3;

% Regularization parameter
alpha = .001;

MAXITER = 400; % Maximum numbers of iterations (default value is 200)

% Load previous results
load data/SVD A 
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2 f3 m3 mn3
if sig_num==1
    f = f1;
    mn = mn1;
elseif sig_num==2
    f = f2;
    mn = mn2;
else
    f = f3;
    mn = mn3;
end

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
ff           = [-2*W*A.'*mn(:); repmat(alpha,2*n,1)];

% Compute MAP estimate by constrained quadratic programming
% using alpha as regularization parameter
QPopt   = optimset('quadprog');
QPopt   = optimset(QPopt,'MaxIter', MAXITER,'Algorithm',...
    'interior-point-convex','Display','iter');
[uvv,val,ef,output] = quadprog(H,ff,AA,b,Aeq,beq,lb,ub,iniguess,QPopt);
recn = W.'*uvv(1:n);

% Save results to file
save data/deconv10_Besov111 n alpha xvec f mn recn sig_num

% Plot results
deconv10a_B111_plot