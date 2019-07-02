clc;
close all;
x=xlsread('D:\Sanjeev\SPR\finalletters.xlsx');
y = proc_pca(x);
% xlswrite('D:\Sanjeev\SPR\finalletterss.xlsx',y);