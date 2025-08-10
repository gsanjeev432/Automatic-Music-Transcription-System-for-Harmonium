# Automatic-Music-Transcription-System-for-Harmonium

This repository contains MATLAB scripts and sample data for developing an automatic transcription system for harmonium recordings.  Feature extraction utilities and basic classification examples are provided to help experiment with different signal processing techniques.

## Repository Structure
- `mfcc/` – functions and examples for computing Mel Frequency Cepstral Coefficients (MFCC) and Fractional Fourier Transform based MFCC (FRFT-MFCC).
- `training/` – spreadsheet feature matrices used to train classifiers.  Files are grouped by feature type such as MFCC, STFT, spectral flux, and zero‑crossing rate.
- `testing/` – feature matrices for evaluating models using the same feature groups as the training set.
- `features/` – combined feature sets and corresponding label spreadsheets used by the MATLAB scripts.
- MATLAB scripts in the project root demonstrate common tasks such as feature extraction (`frftMFCC.m`), training (`svmtraining.m`, `Knn_train.m`) and evaluation (`svmtest.m`).

## Requirements
- MATLAB R2018a or later.
- Signal Processing Toolbox and Statistics and Machine Learning Toolbox for audio processing and classification functions.

## Getting Started
1. **Prepare audio data** – place WAV recordings of individual harmonium notes into a working directory.
2. **Extract features** – edit the path variables at the top of scripts such as `frftMFCC.m` to point to your audio folder and run the script to generate an Excel file containing the selected feature set.
3. **Create training and testing tables** – consolidate feature spreadsheets into `training/` and `testing/` as demonstrated in the repository.  Include a `labels.xlsx` file with the ground‑truth class for each sample.
4. **Train a classifier** – use `svmtraining.m` or `Knn_train.m` to train a multi‑class model.  Update the file paths inside the script to match the location of your feature and label spreadsheets.
5. **Evaluate** – run `svmtest.m` (for SVM) or the equivalent testing script to produce predictions and compute accuracy against the provided labels.

## Data Files
The repository ships with example feature tables (`train_MFCC.xlsx`, `test_MFCC.xlsx`, etc.) under the `training/` and `testing/` directories.  These are intended as references for formatting your own datasets and for quickly validating the scripts.

## Notes
The scripts were originally developed on Windows and reference absolute paths (for example, `D:\Sanjeev\...`).  Adjust these paths before running the code.

## License
This project does not currently include a license.  Please contact the author if you intend to use the code beyond personal experimentation.
