% Test the trained network with noisy non-crime data
%
% Samuli Siltanen September 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 16;
msize  = 6;
colorGray = [.5 .5 .5];

% Load precomputed stuff
load data/deconv02 n xvec f mn f1 mn1
load data/CNN net

% Use pre-trained convolutional neural network for deconvolution
netinput = zeros(n,1,1,1);
netinput(:,1,1,1) = mn(:);
recon = predict(net,netinput);
netinput(:,1,1,1) = mn1(:);
recon1 = predict(net,netinput);

% Create a plot window
figure(1)
clf

% Plot target
p1 = plot(xvec,f,'k','linewidth',lwidth);
set(p1,'color',[.5 .5 .5])
hold on
plot(xvec,recon,'b','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -.2 1])


% Create a plot window
figure(2)
clf

% Plot target
p1 = plot(xvec,f1,'k','linewidth',lwidth);
set(p1,'color',colorGray)
hold on
plot(xvec,recon1,'b','linewidth',lwidth)
set(gca,'xticklabel','','fontsize',fsize)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 -1.2 1.5])


