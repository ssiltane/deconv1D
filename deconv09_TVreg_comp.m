% Use total variation regularization for deconvolution
% The routines deconv02_discretedata_comp.m and deconv04_SVD_comp.m must be 
% computed before this one.
%
% Samuli Siltanen Oct 2019

% Load previous results
load data/deconv02 n xvec Dx f tvec p pn mn
load data/SVD A 

% Regularization parameter
alpha = .001;

% Construct the quadratic optimization problem matrix
H = zeros(3*n);
H(1:n,1:n) = 2*A.'*A;

% Construct the vector h of the linear term
h = alpha*ones(3*n,1);
h(1:n) = -2*A.'*mn(:);

% Construct prior matrix of size (n)x(n). This implements difference
% between consecutive values assuming periodic boundary conditions.
L = eye(n);
L = L-[L(:,end),L(:,1:end-1)];

% Compute reconstruction using quadprog
% Construct input arguments for quadprog.m
Aeq         = [L,-eye(n),eye(n)];
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
save data/deconv09_TVreg n alpha xvec f mn recn

deconv09_TVreg_plot

