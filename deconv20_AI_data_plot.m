% Plot samples from the training data
%
% Samuli Siltanen Sep 2019

% Load precomputed stuff
load data/deconv20 Nexamples 
load data/deconv02 xvec

for eee = 1:Nexamples

    % Save current example to file
    loadcommand = ['load data_CNN/indfun_case_', num2str(eee,'%04d'), '  g Cg p'];
    eval(loadcommand)
    
    % Take a look
    figure(3)
    clf
    plot(xvec,g,'k')
    hold on
    plot(xvec,Cg,'r')
    title(['example ',num2str(eee)])
    axis([0 1 -.1 1])
    pause
end
