clc;
close all;

%% Input training data

traindata = xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\train_features.xlsx');  % excel file where all features of training data are stored

%data labels
labels=xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\train_labels.xlsx');  % excel file where all labels of training data are stored


% select value of k
k = 1; % value of number of nearest neighbours
testdata = xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\test_features.xlsx');  % excel file where all features of testing data are stored

%% Data classification
% output = fitcknn(traindata,labels,'OptimizeHyperparameters','auto',...
%     'HyperparameterOptimizationOptions',...
%     stxruct('AcquisitionFunctionName','expected-improvement-plus'))
output = fitcknn(traindata,labels,'NumNeighbors',5,'Standardize',1);    
predicted_labels = predict(output,testdata);
%   Obtaining testing data labels
testlabel = xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\test_labels.xlsx');
obtained = predicted_labels;


%   Calculating classification accuracy
 tp = 0;
    [r,c] = size(testlabel);
    for  i = 1:r
        for j = 1:c
            if obtained(i,j) == testlabel(i,j)
                tp = tp+1;
            end
        end
    end
    
    accuracy = (tp/r)*100
  