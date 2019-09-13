% Use L1 regularization for deconvolution
% The routines deconv3_naive_comp.m and deconv4_SVD_comp.m must be
% computed before this one.
%
% Samuli Siltanen Feb 2015

% Load previous results
load data/deconv3 n xvec f A mCF mCFn

% Collection of regularization parameters
alphavec = 10.^linspace(-5,1.5,30);

% Construct the quadratic optimization problem matrix
H = zeros(3*n);
H(1:n,1:n) = 2*A.'*A;

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

% Loop over regularization parameters and compute reconstructions
sparsevec = zeros(size(alphavec));
recomat   = zeros(n,length(alphavec));
for iii = 1:length(alphavec)
    % Pick current regularization parameter
    alpha = alphavec(iii);
    
    % Construct the vector h of the linear term
    h = alpha*ones(3*n,1);
    h(1:n) = -2*A.'*mCFn;
    
    % Reconstruct
    [uvv,val,ef,output] = quadprog(H,h,AA,b,Aeq,beq,lb,ub,iniguess,QPopt);
    disp(['Number of iterations: ', num2str(output.iterations)])

    % Compute reconstruction and record the result in the matrix recomat
    recn = uvv(1:n);
    recomat(:,iii) = recn(:);
    
    % Monitor the run
    disp([iii length(alphavec)])
end

% Save all results to disc
save data/TVreg_many n alphavec xvec f mCFn recomat

deconv9b_TVreg_many_plot

