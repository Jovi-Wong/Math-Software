clear all;
%Input the real function
[x,y] = meshgrid(-1:0.01:1);
f = exp(x).*sin(y);

houseInputs = [x(:),y(:)];
houseTargets = f(:);
inputs = houseInputs';
targets = houseTargets';
 
% Create a Fitting Network
hiddenLayerSize = 200;
net = fitnet(hiddenLayerSize);
%net.numLayers = 3;
%net.layerConnect(3,2) = 1;
%net.outputConnect = [0 0 1];
%net.layers{2}.size = 15;
%net.layers{2}.transferFcn = 'tansig';
%net.outputs{3}.range = [1 20];
% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%Train setting
%net.trainFcn = 'trainlm';  Levenberg-Marquardt
%net.trainFcn = 'trainbr';  %Bayesian Regularization
%net.trainFcn = 'trainscg'; %Scaled Conjugate Gradient
%net.trainFcn = 'traingd';  %Gradient Decent
%net.trainFcn = 'traingrp;  %RPROP
%net.trainFcn = 'trainoss;  %One Step SecantAlgorhithm

% Train the Network
[net,tr] = train(net,inputs,targets);
 
% Test the Network
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
 
% View the Network
view(net)
 
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotfit(targets,outputs)
% figure, plotregression(targets,outputs)
% figure, ploterrhist(errors)