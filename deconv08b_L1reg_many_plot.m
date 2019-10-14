% Plot the results of deconv08b_L1reg_many_comp.m
%
% Samuli Siltanen Oct 2019

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 20;
msize  = 6;
colorGray = [.5 .5 .5];
colorRecon= [144 2 190]/255;

% Load precomputed stuff
load data/deconv08b_L1reg_many n alphavec xvec f mn recomat sig_num
ymin = min(f)-.2;
ymax = max(f)+.2;

for iii = 1:length(alphavec)
    
    % Create a plot window
    figure(iii)
    clf
    
    % Current reconstruction and regularization parameter
    recn = recomat(:,iii);
    alpha = alphavec(iii);
    
    % Calculate reconstruction error
    errn = norm(recn(:)-f(:))/norm(f(:));
    
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
    title(['L1 prior reconstruction, \alpha=',num2str(alpha),', error ',num2str(100*errn,'%0.1f'),'%'],'fontsize',fsize)
    
    % To save image to file, remove comment below
    %eval(['print -dtiff -r400 images/TVreg_', num2str(iii,'%03d'), '.tif'])
end

