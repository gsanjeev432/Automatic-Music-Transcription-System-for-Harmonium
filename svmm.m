x=xlsread('D:\Sanjeev\AMT\Database\training\feature.xlsx');  % excel file where all features of 40 images are stored
% x=x(:,1:1140);
Xdata=x;

%  grouping data
b=xlsread('D:\Sanjeev\AMT\Database\training\labels.xlsx');
label = b(:);
test = xlsread('D:\Sanjeev\AMT\Database\testing\feature1.xlsx');  % excel file where all features of 40 images are stored
SVMStruct = svmtrain(Xdata,label);
Group = svmclassify(SVMStruct,test);