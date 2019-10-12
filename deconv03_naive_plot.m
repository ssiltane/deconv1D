% Plot the results of deconv3_naive_comp.m. Show naive reconstruction from
% both inverse-crime data and from noisy data without inverse crime.
%
% Samuli Siltanen Oct 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

% Load precomputed stuff
load data/deconv02 n xvec f 
load data/deconv03 mIC recIC recn

% Calculate reconstruction errors
errIC = norm(recIC(:)-f(:))/norm(f(:));
errn = norm(recn(:)-f(:))/norm(f(:));

% Create a plot window
figure(1)
clf

% Plot the "measurement" WITH INVERSE CRIME
subplot(2,1,1)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,mIC,'b','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title('Data WITH inverse crime','fontsize',fsize)

% Plot reconstruction
subplot(2,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
p2 = plot(xvec,recIC,'b','linewidth',lwidth);
set(p2,'color',colorRecon)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title(['Naive reconstruction WITH inverse crime, error ',num2str(100*errIC,'%0.1f'),'%'],'fontsize',fsize)



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
p2 = plot(xvec,recn,'b','linewidth',lwidth);
set(p2,'color',colorRecon)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title(['Naive reconstruction, no inverse crime, error ',num2str(100*errn,'%0.1f'),'%'],'fontsize',fsize)



