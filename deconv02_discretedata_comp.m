% Simulate discrete convolution operation applied to two different 
% one-dimensional signals. 
%
% The signal length n can be chosen; for example n=128 is a suitable
% choice. Note that n should be a power of two for some of the routines in
% this folder to work.
%
% For the theory behind these computations, please see the book
% Jennifer L Mueller & Samuli Siltanen: "Linear and nonlinear inverse
% problems with practical applications," SIAM 2012.
%
% Samuli Siltanen Oct 2019

% Let's construct discrete approximation of the target
n    = 128;
xvec = [0:(n-1)]/n;
Dx   = xvec(2)-xvec(1);
f1    = convtarget1(xvec);
f2   = convtarget2(xvec);

% Construct the ideal discrete PSF
a    = .04;
nu   = floor(a/Dx);
tvec = [-nu:nu]*Dx; 
p    = PSF(tvec,a);
p    = p/sum(p); % Normalization

% Construct the perturbed discrete PSF
pn    = max(0,p+0.03*max(p)*randn(size(p))); % Avoid inverse crime
pn    = pn/sum(pn); % Normalization

% Construct ideal measurement
m1 = conv2(f1,p,'same');
m2 = conv2(f2,p,'same');

% Construct noisy measurement with modeling error
noiselevel = 0.02;
mn1 = conv2(f1,pn,'same') + noiselevel*max(abs(m))*randn(size(f));
mn2 = conv2(f2,pn,'same') + noiselevel*max(abs(m1))*randn(size(f2));

% Save results to disc
save data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2

% Plot the results
deconv02_discretedata_plot