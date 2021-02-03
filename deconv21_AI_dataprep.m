% Prepare the convolution data into a form readily
% accepted by CNN routines in Matlab's Deep Learning toolbox.
% Here the training data consists of pairs (convolved function, original function)
%
% The routines deconv02_discretedata_comp.m and deconv20_AI_data_comp.m must 
% be computed before this one.
%
% Samuli Siltanen August 2019

NexamplesTrain = 6000;
NexamplesValidation = 3000;

% Initialize data matrices
load data/deconv20 Nexamples 
load data/deconv02 xvec n
XTrain = zeros(n,1,1,NexamplesTrain);
XValidation = zeros(n,1,1,NexamplesValidation);
YTrain = zeros(1,1,n,NexamplesTrain);
YValidation = zeros(1,1,n,NexamplesValidation);
% YTrain = zeros(n,1,1,NexamplesTrain);
% YValidation = zeros(n,1,1,NexamplesValidation);

% Loop over examples
for eee = 1:NexamplesValidation
    
    % Load precomputed results from file
    loadcommand = ['load data_CNN/indfun_case_', num2str(100+eee,'%04d'), '  g Cg p'];
    eval(loadcommand)
    
    % Insert functions to data tensor
    XValidation(:,1,1,eee) = Cg(:);
    YValidation(1,1,:,eee) = g(:);
    
    % Monitor the run
    if mod(eee,100)==0
        disp('Constructing validation data')
        disp([eee NexamplesValidation])
    end
end



% Loop over examples
for eee = 1:NexamplesTrain
    
    % Load precomputed results from file
    loadcommand = ['load data_CNN/indfun_case_', num2str(100+NexamplesValidation+eee,'%04d'), ' g Cg p'];
    eval(loadcommand)
    
    % Insert functions to data tensor
    XTrain(:,1,1,eee) = Cg(:);
    YTrain(1,1,:,eee) = g(:);
    
    % Monitor the run
    if mod(eee,100)==0
        disp('Constructing training data')
        disp([eee NexamplesTrain])
    end
end



% Save all of the generated data into one file to be conveniently used in
% machine learning
save data_CNN/datamat XTrain XValidation YTrain YValidation NexamplesTrain NexamplesValidation
