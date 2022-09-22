% Plot the results of deconv4_SVD_comp.m. Show the singular values of the
% system matrix. 
%
% Samuli Siltanen September 2021

% Parameters for controlling the plot
lwidth = 1;
fsize  = 16;
msize  = 6;

% Load precomputed stuff
load data/SVD A U D V svals
[row,col] = size(A);

% Create a plot window
figure(1)
clf

% Plot singular values
semilogy([1:length(svals)],svals,'b.','markersize',msize)
set(gca,'xtick',[1 round(col/4) round(col/2) round(3*col/4) col],'fontsize',fsize)
axis square
xlim([1 length(svals)])
title('Singular values of the convolution matrix, log scale','fontsize',fsize)

% Create a plot window
figure(2)
clf

% Show a collection of columns of V, in other words singular vectors
for iii = 1:size(V,2)
    plot(V(:,iii),'k','linewidth',lwidth)
    title(['Singular vector ',num2str(iii)],'fontsize',fsize)
    pause
    clf
end

