% Train a CNN for 1-dimensional deconvolution. The files deconv20_AI_data_comp.m
% and deconv21_AI_dataprep.m should be run before this one.
%
% The network architecture here is better than in deconv22_AI_trainCNN.m
%
% The routines deconv02_discretedata_comp.m, deconv20_AI_data_comp.m and 
% deconv21_AI_dataprep.m must be computed before this one.
%
% Samuli Siltanen Oct 2019

% Load precomputed data
load data_CNN/datamat XTrain XValidation YTrain YValidation
load data/deconv02 n

% Construct validation data
ValidationData = cell([1,2]);
ValidationData{1} = XValidation;
ValidationData{2} = YValidation;



% Specify training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',10, ...
    'ValidationData',ValidationData, ...
    'ValidationFrequency',30, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the network
net = trainNetwork(XTrain,YTrain,layers,options);

% Save to disc
save data_CNN/CNN net