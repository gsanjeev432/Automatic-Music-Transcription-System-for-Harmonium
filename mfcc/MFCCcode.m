close all;
clc; 
%%  Data Acquisition 

wavFiles = 'D:\mfcc\training\';          %  Specify data folder
file_ext = '.wav';                        %   Include all .wav files
folder_content = dir ([wavFiles,'*',file_ext]); 
numfiles = length(folder_content);       %   No. of files

%% Define variables
 
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels 
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)

%%      FEATURE EXTRACTION(MFCC and FRFT-MFCC)


%%  Loop for multiple files

for k = 1:numfiles 
    string = [wavFiles,folder_content(k,1).name];
    
    % Read speech samples and sampling rate from file
    
    [ speech, fs ] = audioread( string );


    % Feature extraction (MFCC)
    
    [ MFCCs] = ...
                    mfcc( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
                
    % Feature extraction (FRFT-MFCC)                
    [ FRFTMFCCs] = ...
                    frftdemo( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );

    FRFTMFCCs = FRFTMFCCs';                 %  Transpose of matrix to obtain single row


             
  MFCCs = mean(MFCCs);                      %   Averaging columns
  MFCCs = MFCCs(:,1:1140);                  %   Reducing columns to avoid empty spaces
  features = [MFCCs FRFTMFCCs];             %   Appending both the features (MFCC and FRFT-MFCC)
  xlswrite('trainfeature.xlsx',features,'Sheet1',num2str(k));   %   Writing data to excel spreadsheet
  
end
       