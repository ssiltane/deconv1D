% Plot the results of deconv3_naive_comp.m
%
% Samuli Siltanen January 2015

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];

% Load precomputed stuff
load data/deconv02 n xvec f 
load data/deconv03 mIC recIC recn

% Create a plot window
figure(1)
clf

% Plot the "measurement" WITH INVERSE CRIME
subplot(2,1,1)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,mIC,'r','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title('Data WITH inverse crime','fontsize',fsize)

% Plot reconstruction
subplot(2,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,recIC,'b','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title('Naive reconstruction WITH inverse crime','fontsize',fsize)



% Create a plot window
figure(2)
clf

% Plot target and noisy measurement
subplot(2,1,1)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,mn,'r','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title('Noisy measurement','fontsize',fsize)


% Plot reconstruction
subplot(2,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,recn,'b','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title('Naive reconstruction, no crime','fontsize',fsize)



