% Prepare the convolution data into a form readily
% accepted by CNN routines in Matlab's Deep Learning toolbox.
%
% Here the training data consists of pairs (convolved function, original function)
%
% Samuli Siltanen August 2019

NexamplesTrain = 7000;
NexamplesValidation = 2900;

% Initialize data matrices
load data/deconv20 Nexamples 
load data/deconv02 xvec n
XTrain = zeros(n,1,1,NexamplesTrain);
XValidation = zeros(n,1,1,NexamplesValidation);
YTrain = zeros(1,1,n,NexamplesTrain);
YValidation = zeros(1,1,n,NexamplesValidation);


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
save data/datamat XTrain XValidation YTrain YValidation NexamplesTrain NexamplesValidation
