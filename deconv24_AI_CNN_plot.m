% Test the CNN network trained by routine deconv22_AI_trainCNN.m
% with noisy non-crime data
%
% Samuli Siltanen Oct 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

% Load previous results
load data/deconv02 n xvec Dx f tvec p pn mn
load data/CNN net

% Use pre-trained convolutional neural network for deconvolution
netinput = zeros(n,1,1,1);
netinput(:,1,1,1) = mn(:);
recn = predict(net,netinput);

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
title(['CNN reconstruction, error ',num2str(100*errn,'%0.1f'),'%'],'fontsize',fsize)
