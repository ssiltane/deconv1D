% PLot the results of Deconv10_B111_comp.m
%
% Samuli Siltanen, Feb 2015

% Parameters for controlling the plot
lwidth = 1;
fsize  = 20;
msize  = 6;

% Load precomputed stuff
load data/deconv1_cont Nt t psi Nx x convres a
load data/DC10_Besov111 recn W

% Create a plot window
figure(1)
clf

% Plot target (both continuous and discrete)
subplot(3,1,1)
plot(x,target1(x),'k','linewidth',lwidth)
hold on
plot(xvec,target1(xvec),'k.','markersize',msize)
%plot(xvec,recIC,'r.','markersize',msize)
axis([0 1 -.1 1.1])
title('Original target function','fontsize',fsize)

% Plot the datasets WITHOUT INVERSE CRIME
subplot(3,1,2)
plot(x,convres,'r','linewidth',lwidth)
hold on
plot(xvec,mCFn,'m.','markersize',msize)
axis([0 1 -.1 1.1])
title('Data WITHOUT inverse crime','fontsize',fsize)

% Plot reconstruction
subplot(3,1,3)
plot(x,target1(x),'k','linewidth',lwidth)
hold on
plot(xvec,recn,'m','linewidth',lwidth)
axis([0 1 -.1 1.1])
title('B111 reconstruction WITHOUT inverse crime, with noise','fontsize',fsize)
