% Plot the results of deconv2_discretedata_comp.m
%
% Samuli Siltanen January 2015

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 16;
msize  = 6;
colorGray = [.5 .5 .5];

% Load precomputed stuff
load data/deconv02 n xvec Dx f tvec p pn m mn f1 mn1 m1

% Create a plot window
figure(1)
clf

% Plot target 
subplot(3,1,1)
plot(xvec,f,'k','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1])
title('Ground truth: signal 1','fontsize',fsize)

% Plot ideal convolution result 
subplot(3,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,m,'b','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1])
title('Convolution (blue) of signal 1 (gray)','fontsize',fsize)


% Plot noisy data
subplot(3,1,3)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,mn,'r','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1])
title('Noisy measurement (red) of signal 1 (gray)','fontsize',fsize)


% Create a plot window
figure(3)
clf

% Plot target 
subplot(3,1,1)
plot(xvec,f1,'k','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -1.2 1.5])
title('Ground truth: signal 2','fontsize',fsize)

% Plot ideal convolution result 
subplot(3,1,2)
p1 = plot(xvec,f1,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,m1,'b','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -1.2 1.5])
title('Convolution (blue) of signal 2 (gray)','fontsize',fsize)


% Plot noisy data
subplot(3,1,3)
p1 = plot(xvec,f1,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,mn1,'r','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -1.2 1.5])
title('Noisy measurement (red) of signal 2 (gray)','fontsize',fsize)




% Create a plot window
figure(2)
clf

% Plot ideal and perturbed PSF
plot(p,'b','linewidth',lwidth)
hold on
plot(pn,'r','linewidth',lwidth)
set(gca,'ytick',[0,max([max(p),max(pn)])],'fontsize',fsize)
title('Ideal convolution kernel (blue) and kernel with modelling error (red)','fontsize',fsize)
