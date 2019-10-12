% Plot some predictions calculated by the convolutional neural network for
% the one-dimensional deconvolution problem
%
% Samuli Siltanen Oct 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

load data/CNN net
load data/deconv02 xvec n

for eee = 1:10
    
    % Load precomputed results from file
    loadcommand = ['load data_CNN/indfun_case_', num2str(eee,'%04d'), '  g Cg p'];
    eval(loadcommand)
    
    % Use pre-trained convolutional neural network for deconvolution
    netinput = zeros(n,1,1,1);
    netinput(:,1,1,1) = Cg(:);
    recon = predict(net,netinput);
    
    % Create a plot window
    figure(1)
    clf
    
    % Plot target
    subplot(2,1,1)
    p1 = plot(xvec,g,'k','linewidth',lwidth);
    set(p1,'color',colorGray)
    hold on
    plot(xvec,Cg,'b','linewidth',lwidth)
    set(gca,'xticklabel','','fontsize',fsize)
    set(gca,'ytick',[0,1],'fontsize',fsize)
    axis([0 1 -.2 1])
    title(['Ground truth (gray) and ideal data (blue)'],'fontsize',fsize)

    subplot(2,1,2)
    p1 = plot(xvec,g,'k','linewidth',lwidth);
    set(p1,'color',colorGray)
    hold on
    p2 = plot(xvec,recon,'b','linewidth',lwidth);
    set(p2,'color',colorRecon)
    set(gca,'xticklabel','','fontsize',fsize)
    set(gca,'ytick',[0,1],'fontsize',fsize)
    axis([0 1 -.2 1])
        title(['Ground truth (gray) and CNN prediction (purple)'],'fontsize',fsize)

end