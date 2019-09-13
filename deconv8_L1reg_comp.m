% Use L1 regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be
% computed before this one.
%
% Samuli Siltanen Feb 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn

% Regularization parameter
alpha = .01;

% Construct the quadratic optimization problem matrix
H = zeros(3*n);
H(1:n,1:n) = 2*A.'*A;

% Construct the vector h of the linear term
h = alpha*ones(3*n,1);
h(1:n) = -2*A.'*mCFn;

% Compute reconstruction using quadprog
% Construct input arguments for quadprog.m
Aeq         = [eye(n),-eye(n),eye(n)];
beq         = zeros(n,1);
lb          = [repmat(-Inf,n,1);zeros(2*n,1)];
ub          = repmat(Inf,3*n,1);
AA          = -eye(3*n);
AA(1:n,1:n) = zeros(n,n);
iniguess    = zeros(3*n,1);
b           = [repmat(10,n,1);zeros(2*n,1)];
MAXITER = 200; % Maximum numbers of iterations, Matlab's default value is 200
QPopt   = optimset('quadprog');
QPopt   = optimset(QPopt,'MaxIter', MAXITER,'Algorithm',...
    'interior-point-convex','Display','iter');
[uvv,val,ef,output] = quadprog(H,h,AA,b,Aeq,beq,lb,ub,iniguess,QPopt);
recn = uvv(1:n);
disp(['Number of iterations: ', num2str(output.iterations)])

% Save results to disc
save data/L1reg n alpha xvec f mCFn recn

deconv8_L1reg_plot

