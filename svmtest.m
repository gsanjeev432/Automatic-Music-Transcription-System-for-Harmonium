clc;
clear all;
close all;
load model; 


[ speech, fs, nbits ] = wavread('D:\Sanjeev\AMT\Database\testing\74.wav');        %   reading files one by one
 
% Define variables
Tw = 25;                % analysis frame duration (ms)
Ts = 10;                % analysis frame shift (ms)
alpha = 0.97;           % preemphasis coefficient
M = 40;                 % number of filterbank channels 
C = 12;                 % number of cepstral coefficients
L = 22;                 % cepstral sine lifter parameter
LF = 130;               % lower frequency limit (Hz)
HF = 6854;              % upper frequency limit (Hz)
  

% Feature extraction (feature vectors as columns)
  
  [ MFCCs] = ...
                mfcc( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
  
  [m,n] = size(MFCCs);            
  test_sorted = sum(MFCCs,1)/m;
test_sorted = test_sorted(:,1:1140)';
[itrfin] = multisvm( x,C,test_sorted);

% if itrfin==1
%     fprintf('anger')
%     
% elseif itrfin==2
%     
%     fprintf('disgust')
%     
% elseif itrfin==3
%     
%     fprintf('fear')
%     
% elseif itrfin==4
%     
%     fprintf('Happy')
%     
% elseif itrfin==5
%     
%     fprintf('Normal')
%     
% elseif itrfin==6
%     fprintf('Sad')
%     
% elseif itrfin==7
%     
%     fprintf('Surprise')
%     
% end



