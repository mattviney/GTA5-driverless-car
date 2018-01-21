%Matt Viney - 21/01/18

%Train a CNN using the AlexNet layer architecture. 

%Name of three categories (folder names)
categories = {'Forward_randomized', 'Right_randomized', 'Left_randomized'};
%Folder location of image categories
rootFolder = 'C:\Users\Matt\Documents\MATLAB\GTA V\Training_images4';
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');


layers = [ ...
    imageInputLayer([227 227 3])
    convolution2dLayer(11, 96, 'Stride', [4 4], 'NumChannels' , 3)
    reluLayer
    crossChannelNormalizationLayer(5, 'Alpha', 0.0001, 'Beta', 0.75, 'K', 1)
    maxPooling2dLayer(3, 'Stride', 2)
    convolution2dLayer(5, 256, 'Stride', [1 1])
    reluLayer
    crossChannelNormalizationLayer(5, 'Alpha', 0.0001, 'Beta', 0.75, 'K', 1)
    maxPooling2dLayer(3, 'Stride', 2)
    convolution2dLayer(3, 384, 'Stride', [1 1])
    reluLayer
    convolution2dLayer(3, 384, 'Stride', [1 1])
    reluLayer
    convolution2dLayer(3, 256, 'Stride', [1 1])
    reluLayer
    maxPooling2dLayer(3, 'Stride', 2)
    fullyConnectedLayer(4096)
    reluLayer
    fullyConnectedLayer(4096)
    reluLayer
    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm','InitialLearnRate',0.001, ...
    'MaxEpochs',64, 'Plots','training-progress');

GTAnnet_cars2 = trainNetwork(imds,layers,options);


