close all;  
clc; 
%% 
wavFiles = 'D:\mfcc\testing\';
file_ext = '.wav';
folder_content = dir ([wavFiles,'*',file_ext]); 
numfiles = length(folder_content);
%%

    % Define variables
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels 
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)

%%
for k = 1:numfiles 
    string = [wavFiles,folder_content(k,1).name];
    % Read speech samples, sampling rate and precision from file
    [ speech, fs ] = audioread( string );

% Feature extraction (feature vectors as columns)
[ FRFTMFCCs, FBEs, frames ] = ...
                    frftdemo( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );

FRFTMFCCs = FRFTMFCCs';
                
  xlswrite('feature.xlsx',FRFTMFCCs,'Sheet1',num2str(k));
  
end