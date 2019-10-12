% Plot the results of deconv05_truncSVD_comp.m
%
% Samuli Siltanen Oct 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

% Load precomputed stuff
load data/deconv05 n xvec f mn recn r_alpha sig_num
load data/SVD A U D V svals
[row,col] = size(A);
ymin = min(f)-.2;
ymax = max(f)+.2;

% Calculate reconstruction error
errn = norm(recn(:)-f(:))/norm(f(:));

% Create a plot window
figure(1)
clf

% Plot the data
subplot(2,1,1)
p1 = plot(xvec,f,'k','linewidth',lwidth);
set(p1,'color',colorGray)
hold on
plot(xvec,mn,'r','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 ymin ymax])
title('Noisy measurement (red) of signal 1 (gray)','fontsize',fsize)

% Plot reconstruction
subplot(2,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth);
set(p1,'color',colorGray)
hold on
p2 = plot(xvec,recn,'b','linewidth',lwidth);
set(p2,'color',colorRecon)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 ymin ymax])
title(['tSVD reconstruction, r_\alpha=',num2str(r_alpha),', error ',num2str(100*errn,'%0.1f'),'%'],'fontsize',fsize)

% Create a plot window
figure(2)
clf

% Plot singular values, showing the ones actually used as red points
semilogy([1:length(svals)],svals,'b.','markersize',msize)
hold on
semilogy([1:r_alpha],svals(1:r_alpha),'r.','markersize',msize)
set(gca,'xtick',[1 round(col/4) round(col/2) round(3*col/4) col],'fontsize',fsize)
axis square
xlim([1 length(svals)])
title('Only red singular values used in the reconstruction','fontsize',fsize)
