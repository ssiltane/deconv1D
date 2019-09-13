% Plot the results of deconv4_SVD_comp.m
%
% Samuli Siltanen January 2015

% Parameters for controlling the plot
lwidth = 1;
fsize  = 20;
msize  = 6;

% Load precomputed stuff
load data/SVD A U D V svals

% Create a plot window
figure(1)
clf

% Plot singular values
semilogy([1:length(svals)],svals,'b.','markersize',msize)
axis square
xlim([1 length(svals)])
 
% % Create a plot window
% figure(2)
% clf
% 
% % Show a collection of columns of V
% for iii = 1:size(V,2)
%     plot(V(:,iii),'k','linewidth',lwidth)
%     pause
%     clf
% end

