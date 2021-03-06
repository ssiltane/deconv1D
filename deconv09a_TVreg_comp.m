% Use total variation regularization for deconvolution
%
% The routines deconv02_discretedata_comp.m and deconv03_naive_comp.m
% must be computed before this one.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Sep 2020

% Choose signal 1 or 2 or 3
sig_num = 1;

% Regularization parameter
alpha = .01;

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
save data/deconv09_TVreg n alpha xvec f mn recn sig_num

deconv09a_TVreg_plot

