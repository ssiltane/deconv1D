load data/CNN net
load data/deconv02 xvec n

for eee = 1:100
    
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
    plot(xvec,g,'k','linewidth',lwidth)
    hold on
    plot(xvec,Cg,'r','linewidth',lwidth)
    set(gca,'xticklabel','','fontsize',fsize)
    set(gca,'ytick',[0,1],'fontsize',fsize)
    axis([0 1 -.2 1])
    subplot(2,1,2)
    p1 = plot(xvec,g,'k','linewidth',lwidth);
    set(p1,'color',[.5 .5 .5])
    hold on
    plot(xvec,recon,'b','linewidth',lwidth)
    set(gca,'xticklabel','','fontsize',fsize)
    set(gca,'ytick',[0,1],'fontsize',fsize)
    axis([0 1 -.2 1])
    
end