close all;  
clc; 

%%  Data Acquisition 

wavFiles = 'D:\mfcc\training\';             %  Specify data folder
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
    xlswrite('attack.xlsx',attack,'Sheet1',num2str(k));  %  Write features to Excel spreadsheet
    
    %   Repeat these steps for all features
    
    %%  RMS energy
    
    energy = exportation(features.dynamics.rms);
    energy = energy(~cellfun(@isstr,energy));
    energy = energy';
    xlswrite('energy.xlsx',energy,'Sheet1',num2str(k));
    
    %%  Zero crossing rate
    
    zerocross = exportation(features.timbre.zerocross);
    zerocross = zerocross(~cellfun(@isstr,zerocross));
    zerocross = zerocross';
    xlswrite('zerocross.xlsx',zerocross,'Sheet1',num2str(k));
    
    %%  Spectral flux
    
    flux = exportation(features.timbre.spectralflux);
    flux = flux(~cellfun(@isstr,flux));
    flux = flux';
    xlswrite('flux.xlsx',flux,'Sheet1',num2str(k));
     
    %%  MFCC
    
    mfccs = exportation(features.spectral.mfcc);
    mfccs = mfccs(~cellfun(@isstr,mfccs));
    mfccs = mfccs';
    %   Delta MFCC
    dmfccs = exportation(features.spectral.dmfcc);
    dmfccs = dmfccs(~cellfun(@isstr,dmfccs));
    dmfccs = dmfccs';
    %   Delta-Delta MFCC
    ddmfccs = exportation(features.spectral.ddmfcc);
    ddmfccs = ddmfccs(~cellfun(@isstr,ddmfccs));
    ddmfccs = ddmfccs';
    data = [mfccs dmfccs ddmfccs];                      %   Appending MFCC,Delta-MFCC,Delta-Delta MFCC
    xlswrite('mfcc.xlsx',data,'Sheet1',num2str(k));

end