clc;
close all;

x=xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\train_features.xlsx');  % excel file where all features of 40 images are stored
% x=x(:,1:1140);
Xdata=x;

%  grouping data
b=xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\train_labels.xlsx');
label = b(:);
test = xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\test_features.xlsx');  % excel file where all features of 40 images are stored
output = multisvm(Xdata,label,test);
required = xlsread('D:\Sanjeev\Sanjivni_Mam_Speech\database\train\test_labels.xlsx');
 tp = 0;
    [r c] = size(required);
    for  i = 1:r
        for j = 1:c
            if output(i,j) == required(i,j)
                tp = tp+1;
            end
        end
    end
    
    accuracy = (tp/r)*100
