% Simulate discrete convolution operation applied to different 
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
% Samuli Siltanen Sep 2022

%% Let's construct a set of target vectors

% Synthetic cases
n    = 256; 
xvec = [0:(n-1)]/n;
Dx  = xvec(2)-xvec(1);
f1   = convtarget1(xvec);
f2   = convtarget2(xvec);

% Load temperature data measured by Kumpula weather station
load data/DailyMaxTempKumpula2020 T
f3 = T(1:n);
f3 = f3(:).';

% Another synthetic case, with spectral peaks at certain wavelengths. 
% This example is inspired by the spectrum of fluorescent lighting
f4 = zeros(1,n);
tmpx = linspace(400,670,n);
%
tmpvec1 = abs(tmpx-430);
ind1 = min(find(tmpvec1==min(tmpvec1)));
f4(ind1) = .2;
%
tmpvec2 = abs(tmpx-490);
ind2 = min(find(tmpvec2==min(tmpvec2)));
f4(ind2) = .17;
%
tmpvec3 = abs(tmpx-550);
ind3 = min(find(tmpvec3==min(tmpvec3)));
f4(ind3) = .9;
%
tmpvec4 = abs(tmpx-580);
ind4 = min(find(tmpvec4==min(tmpvec4)));
f4(ind4) = .23;
%
tmpvec5 = abs(tmpx-610);
ind5 = min(find(tmpvec5==min(tmpvec5)));
f4(ind5) = .98;
%
tmpvec6 = abs(tmpx-620);
ind6 = min(find(tmpvec6==min(tmpvec6)));
f4(ind6) = .2;

%% Compute convolutions

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
m4 = conv2(f4,p,'same');

% Construct noisy measurement with modeling error
noiselevel = 0.02;
mn1 = conv2(f1,pn,'same') + noiselevel*max(abs(m1))*randn(size(f1));
mn2 = conv2(f2,pn,'same') + noiselevel*max(abs(m1))*randn(size(f2));
mn4 = conv2(f4,pn,'same') + noiselevel*max(abs(m1))*randn(size(f4));

% Construct ideal and "noisy" measurement with modeling error
m3  = conv2(f3,pn,'same');
mn3 = m3;

% Save results to disc
save data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2 f3 m3 mn3 f4 m4 mn4

% Plot the results
deconv02_discretedata_plot