close all;  
clc; 

%%  Data Acquisition 

wavFiles =  'D:\Sanjeev\speech_recognition\train\';             %  Specify data folder
file_ext = '.wav';                          %   Include all .wav files
folder_content = dir ([wavFiles,'*',file_ext]); 
numfiles = length(folder_content);          %   No. of files

%%      FEATURE EXTRACTION(Spectral and Timbral)


%%  Loop for multiple files

for k = 1:numfiles 
    string = [wavFiles,folder_content(k,1).name];   %   Filename
    
%     Read speech samples and sampling rate from file
    
    wavfile = miraudio(string);             %   Read file information
    features = mirfeatures(wavfile);        %   Extract all features
   
    %%  Attack time
    
    attack = exportation(features.rhythm.attack.time);   %  Exportation converts scalar array to cell array to be stored
    attack = attack(~cellfun(@isstr,attack));            %  Cell function to remove string from cell array
    attack = attack';                                    %  Transpose of matrix to obtain single row
    disp(strcat('attack',folder_content(k,1).name));
    xlswrite('attack.xlsx',attack,'Sheet1',num2str(k));  %  Write features to Excel spreadsheet
    
    %   Repeat these steps for all features
    
    %%  RMS energy
    
    energy = exportation(features.dynamics.rms);
    energy = energy(~cellfun(@isstr,energy));
    energy = energy';
    disp(strcat('energy',folder_content(k,1).name));
    xlswrite('energy.xlsx',energy,'Sheet1',num2str(k));
    
    %%  Zero crossing rate
    
    zerocross = exportation(features.timbre.zerocross);
    zerocross = zerocross(~cellfun(@isstr,zerocross));
    zerocross = zerocross';
    disp(strcat('zerocross',folder_content(k,1).name));
    xlswrite('zerocross.xlsx',zerocross,'Sheet1',num2str(k));
    
    %%  Spectral flux
    
    flux = exportation(features.timbre.spectralflux);
    flux = flux(~cellfun(@isstr,flux));
    flux = flux';
    disp(strcat('flux',folder_content(k,1).name));
    xlswrite('flux.xlsx',flux,'Sheet1',num2str(k));
     
    %%  MFCC
    
    mfccs = exportation(features.spectral.mfcc);
    mfccs = mfccs(~cellfun(@isstr,mfccs));
    mfccs = mfccs';
    disp(strcat('mfccs',folder_content(k,1).name));
    xlswrite('mfccs.xlsx',mfccs,'Sheet1',num2str(k));
    
    %%  Delta MFCC
    dmfccs = exportation(features.spectral.dmfcc);
    dmfccs = dmfccs(~cellfun(@isstr,dmfccs));
    dmfccs = dmfccs';
    disp(strcat('dmfccs',folder_content(k,1).name));
    xlswrite('dmfccs.xlsx',dmfccs,'Sheet1',num2str(k));
    
    %%   Delta-Delta MFCC
    ddmfccs = exportation(features.spectral.ddmfcc);
    ddmfccs = ddmfccs(~cellfun(@isstr,ddmfccs));
    ddmfccs = ddmfccs';
    disp(strcat('ddmfccs',folder_content(k,1).name));
%     data = [mfccs dmfccs ddmfccs];                      %   Appending MFCC,Delta-MFCC,Delta-Delta MFCC
    xlswrite('ddmfccs.xlsx',ddmfccs,'Sheet1',num2str(k));

end