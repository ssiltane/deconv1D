% Train a CNN for 1-dimensional deconvolution. The files deconv20_AI_data_comp.m
% and deconv21_AI_dataprep.m should be run before this one.
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

% Design a shallow network architecture
layers = [ % RMSE 0.13, 1000 epcohs
    imageInputLayer([n 1 1])
    convolution2dLayer([15 1],60,"Name","convfirst","Padding","same")
    tanhLayer("Name","sigmoid")
    fullyConnectedLayer(n,"Name","fc")
    regressionLayer];


% Specify training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',500, ...
    'ValidationData',ValidationData, ...
    'ValidationFrequency',30, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the network
net = trainNetwork(XTrain,YTrain,layers,options);

% Save to disc
save data_CNN/CNN_shallow net