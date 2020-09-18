% Train a CNN for 1-dimensional deconvolution. The files deconv20_AI_data_comp.m
% and deconv21_AI_dataprep.m should be run before this one.
%
% The routines deconv02_discretedata_comp.m, deconv20_AI_data_comp.m and
% deconv21_AI_dataprep.m must be computed before this one.
%
% Samuli Siltanen Sep 2020

% Load precomputed data
load data_CNN/datamat XTrain XValidation YTrain YValidation
load data/deconv02 n

% Construct validation data
ValidationData = cell([1,2]);
ValidationData{1} = XValidation;
ValidationData{2} = YValidation;

% layers = [% 0.07, 1000 epochs
%     imageInputLayer([n 1 1])
%     convolution2dLayer([9 1],20,"Name","convfirst","Padding","same")
%     tanhLayer("Name","sigmoid")
%     convolution2dLayer([3 1],60,"Name","convfirst","Padding","same")
%     tanhLayer("Name","sigmoid")
%     fullyConnectedLayer(n,"Name","fc")
%     regressionLayer];

layers = [%0.09
    imageInputLayer([n 1 1])
    convolution2dLayer([3 1],20,"Name","convfirst1","Padding","same")
    reluLayer("Name","l1")
    convolution2dLayer([3 1],20,"Name","convfirst2","Padding","same")
    reluLayer("Name","l2")
    convolution2dLayer([3 1],20,"Name","convfirst3","Padding","same")
    reluLayer("Name","l3")
    convolution2dLayer([3 1],20,"Name","convfirst4","Padding","same")
    reluLayer("Name","l4")
%     convolution2dLayer([3 1],10,"Name","convfirst5","Padding","same")
%     reluLayer("Name","l5")
%     convolution2dLayer([3 1],10,"Name","convfirst6","Padding","same")
%     reluLayer("Name","l6")
    fullyConnectedLayer(n,"Name","fc")
    regressionLayer];



% This is the architecture I used first, but the one above is better
% layers = [
%     imageInputLayer([n 1 1])
%     convolution2dLayer([3 1],36,"Name","convfirst","Padding","same")
%     leakyReluLayer(0.01,"Name","leakyrelu")
%     averagePooling2dLayer([3 1],"Name","avepool","Padding","same","Stride",[2 1]);
%     convolution2dLayer([3 1],20,"Name","convsecond","Padding","same")
%     leakyReluLayer("Name","relu")
%     fullyConnectedLayer(n,"Name","fc")
%     regressionLayer];

% Specify training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',200, ...
    'ValidationData',ValidationData, ...
    'ValidationFrequency',30, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the network
net = trainNetwork(XTrain,YTrain,layers,options);

% Save to disc
save data_CNN/CNN_deep net