% Test the CNN network trained by routine deconv22_AI_trainCNN.m
% with noisy non-crime data
%
% Samuli Siltanen Sep 2020

% Choose signal 1 or 2 or 3
sig_num = 1;

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

% Load previous results
%load data_CNN/CNN_deep net
load data_CNN/CNN_shallow net
load data/deconv02 n xvec Dx tvec p pn f1 m1 mn1 f2 m2 mn2 f3 m3 mn3
if sig_num==1
    f = f1;
    %mn = mn1;
    mn = m1;
elseif sig_num==2
    f = f2;
    mn = mn2;
else
    f = f3;
    mn = mn3;
end
ymin = min(f)-.2;
ymax = max(f)+.2;

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
p1 = plot(xvec,f,'k','linewidth',lwidth);
set(p1,'color',colorGray)
hold on
plot(xvec,mn,'r','linewidth',lwidth)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 ymin ymax])
title(['Noisy measurement (red) of signal ',num2str(sig_num),' (gray)'],'fontsize',fsize)

% Plot reconstruction
subplot(2,1,2)
p1 = plot(xvec,f,'k','linewidth',lwidth);
set(p1,'color',colorGray)
hold on
p2 = plot(xvec,recn,'b','linewidth',lwidth);
set(p2,'color',colorRecon)
set(gca,'ytick',[0,1],'fontsize',fsize)
axis([0 1 ymin ymax])
title(['CNN reconstruction, error ',num2str(100*errn,'%0.1f'),'%'],'fontsize',fsize)
