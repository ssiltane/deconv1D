% Plot the results of deconv6_Tikhonov_comp.m
%
% Samuli Siltanen February 2015

% Parameters for controlling the plot
lwidth = 1;
fsize  = 20;
msize  = 6;

% Load precomputed stuff
load data/deconv1_cont Nt t psi Nx x convres a
load data/tikhonov6 n xvec f mCF rec mCFn recn alpha

% Create a plot window
figure(1)
clf

% Plot target (both continuous and discrete)
subplot(3,1,1)
plot(x,target1(x),'k','linewidth',lwidth)
hold on
plot(xvec,target1(xvec),'k.','markersize',msize)
%plot(xvec,recIC,'r.','markersize',msize)
xlim([0 1])
title('Original target function','fontsize',fsize)

% Plot the datasets WITHOUT INVERSE CRIME
subplot(3,1,2)
plot(x,convres,'r','linewidth',lwidth)
hold on
%plot(xvec,mCF,'b.','markersize',msize)
plot(xvec,mCFn,'m.','markersize',msize)
xlim([0 1])
title('Data WITHOUT inverse crime','fontsize',fsize)

% Plot reconstruction
subplot(3,1,3)
plot(x,target1(x),'k','linewidth',lwidth)
hold on
plot(xvec,recn,'m','linewidth',lwidth)
%plot(xvec,recn,'m.','markersize',msize)
xlim([0 1])
title('Tikhonov reconstruction WITHOUT inverse crime, with noise','fontsize',fsize)

% Create a plot window
figure(2)
clf

% Load precomputed stuff
load data/SVD svals 

% Plot singular values, showing the ones actually used as red points
semilogy([1:length(svals)],svals,'b.','markersize',msize)
hold on
semilogy([1:length(svals)],svals./(svals.^2+alpha),'r.','markersize',msize)
axis square
xlim([1 length(svals)])
 