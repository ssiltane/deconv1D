% Simulate discrete convolution. The signal length n can be chosen.
%
% Samuli Siltanen Oct 2019

% Let's construct discrete approximation of the target
n    = 128;
xvec = [0:(n-1)]/n;
Dx   = xvec(2)-xvec(1);
f    = convtarget0(xvec);
f1   = convtarget1(xvec);

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
m = conv2(f,p,'same');
m1 = conv2(f1,p,'same');

% Construct noisy measurement with modeling error
noiselevel = 0.02;
mn = conv2(f,pn,'same') + noiselevel*max(abs(m))*randn(size(f));
mn1 = conv2(f1,pn,'same') + noiselevel*max(abs(m1))*randn(size(f1));

% Save results to disc
save data/deconv02 n xvec Dx f tvec p pn m mn f1 mn1 m1

% Plot the results
deconv02_discretedata_plot