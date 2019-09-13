% Plot the results of deconv6_Tikhonov_comp.m
%
% Samuli Siltanen February 2015

% Parameters for controlling the plot
lwidth = 1.5;
fsize  = 12;
msize  = 6;

% Load precomputed stuff
load data/deconv1_cont Nt t psi Nx x convres a
load data/TVreg_many n alphavec xvec f mCFn recomat

for iii = 1:length(alphavec)
    
    % Create a plot window
    figure(iii)
    clf
    
    % Plot reconstruction
    plot(x,target1(x),'k','linewidth',lwidth/2)
    hold on
    plot(xvec,recomat(:,iii),'m','linewidth',lwidth)
    axis([0 1 -.1 1.1])
    title('Tikhonov reconstruction WITHOUT inverse crime, with noise','fontsize',fsize)
    
    eval(['print -dtiff -r400 images/TVreg_', num2str(iii,'%03d'), '.tif'])
end

