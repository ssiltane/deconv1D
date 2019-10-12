% Plot the results of deconv09_TVreg_comp.m
%
% Samuli Siltanen Oct 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

% Load precomputed stuff
load  data/deconv09_TVreg n alpha xvec f mn recn

% Calculate reconstruction error
errn = norm(recn(:)-f(:))/norm(f(:));

% Create a plot window
figure(1)
clf

% Plot the data
subplot(2,1,1)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
plot(xvec,mn,'r','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1])
title('Noisy measurement (red) of signal 1 (gray)','fontsize',fsize)

% Plot reconstruction
subplot(2,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth)
set(p1,'color',colorGray)
hold on
p2 = plot(xvec,recn,'b','linewidth',lwidth);
set(p2,'color',colorRecon)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1.6])
title(['Total variation reconstruction, \alpha=',num2str(alpha),', error ',num2str(100*errn,'%0.1f'),'%'],'fontsize',fsize)
