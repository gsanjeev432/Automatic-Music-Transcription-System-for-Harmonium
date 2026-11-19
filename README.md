# Automatic Music Transcription System for Harmonium

This repository contains MATLAB scripts, helper functions, and sample feature tables for experimenting with **automatic harmonium note/music transcription** workflows. The current codebase is organized around a classical ML pipeline:

1. Read `.wav` recordings.
2. Extract frame-level audio descriptors (MFCC, FRFT-MFCC, STFT, spectral/rhythmic features).
3. Export features to Excel spreadsheets.
4. Train classifiers (SVM / KNN) on spreadsheet-based feature matrices.
5. Evaluate predictions against ground-truth labels.

> The project is best treated as a **research/academic prototype**. Most scripts use hard-coded local paths and require small edits before they can run on a new machine.

## What is in this repository

### Core scripts (project root)

- `frftMFCC.m` - batch extraction of FRFT-MFCC features from a folder of WAV files, writing each file's features into `feature.xlsx`.
- `Otherfeatcode.m` - extraction of additional MIR features (attack time, energy, zero-crossing, flux, MFCC, delta, delta-delta) and export to separate Excel sheets.
- `svmtraining.m` - loads train/test feature tables from Excel, runs multiclass SVM via `multisvm.m`, computes accuracy.
- `Knn_train.m` - trains and evaluates a KNN classifier (`fitcknn`) from Excel features/labels.
- `svmtest.m` - example single-file inference flow: load model, extract MFCCs from one WAV file, classify.
- `multisvm.m` / `svmm.m` - helper implementation for one-vs-all style multiclass SVM logic.
- `STFTcode.m`, `MFCCcode.m`, `pcaa.m`, `mfcc.m`, `stft.m` - signal-processing / feature utility scripts.

### Data and feature folders

- `training/` - example training feature matrices (`train_MFCC.xlsx`, `train_STFT.xlsx`, etc.).
- `testing/` - example testing feature matrices (`test_MFCC.xlsx`, `test_STFT.xlsx`, etc.).
- `features/` - alternate organized feature exports and labels.
- `mfcc/` - MFCC/FRFT helper functions, examples, and reference outputs.
- `model.mat`, `labels.xlsx`, `truelabels.xlsx` - sample model/label artifacts used by scripts.

## Expected workflow

### 1) Prepare audio data

- Collect harmonium recordings as `.wav` files.
- Keep training and testing audio in separate folders.
- Ensure labels are encoded numerically (class IDs) in a matching Excel file.

### 2) Extract features

Use one or both strategies:

- **FRFT-MFCC extraction** via `frftMFCC.m`.
- **Other MIR features** via `Otherfeatcode.m`.

Both scripts iterate over a folder and write feature rows/sheets into Excel workbooks. You can then combine or select feature sets (e.g., MFCC-only, STFT-only, combined).

### 3) Assemble train/test matrices

- Store resulting feature tables under `training/` and `testing/` (or update script paths to your preferred location).
- Keep row ordering consistent with label files.

### 4) Train a model

- Run `svmtraining.m` for SVM-based classification.
- Run `Knn_train.m` for KNN baseline comparison.

### 5) Evaluate

- Scripts compute simple accuracy by comparing predicted labels to expected labels.
- You can extend evaluation with confusion matrices, precision/recall, or per-note accuracy.

## Environment and dependencies

### MATLAB

- Recommended: MATLAB R2018a+.
- Toolboxes commonly required by these scripts:
  - Signal Processing Toolbox
  - Statistics and Machine Learning Toolbox

### Third-party toolbox usage

`Otherfeatcode.m` uses functions such as `miraudio` / `mirfeatures` and `exportation`, which are associated with the **MIRToolbox** ecosystem. Install/configure that toolbox if you intend to run this script as-is.

## Important setup notes before running scripts

1. **Update hard-coded paths**
   Many files reference absolute Windows paths like `D:\Sanjeev\...`. Replace these with paths on your machine.

2. **Check MATLAB function compatibility**
   `wavread` appears in legacy code (`svmtest.m`). In modern MATLAB versions, replace with `audioread` where needed.

3. **Excel I/O expectations**
   The pipeline depends heavily on `xlsread` / `xlswrite`. Confirm Excel support is available in your MATLAB environment.

4. **Feature dimensionality consistency**
   Train and test matrices must have identical feature dimensions and ordering.

## Quick start checklist

- [ ] Edit all file paths in the scripts you will run.
- [ ] Verify required toolbox functions are on MATLAB path.
- [ ] Run feature extraction on your training and testing WAV folders.
- [ ] Build/update `train_*.xlsx`, `test_*.xlsx`, and label spreadsheets.
- [ ] Train (`svmtraining.m` or `Knn_train.m`).
- [ ] Run evaluation and review accuracy.

## Current limitations

- Minimal automation (manual path editing and spreadsheet management).
- No unified entry-point script for end-to-end execution.
- Limited experiment tracking/reproducibility metadata.
- No explicit open-source license file included.

## Suggested improvements (future work)

- Convert hard-coded paths to configurable parameters.
- Move from Excel-based data exchange to `.mat` or `.csv` pipelines.
- Add standardized train/validation/test split scripts.
- Add confusion matrix + detailed metrics outputs.
- Provide one master script to run complete workflow.

## License

No license file is currently included in this repository. If you plan to reuse or redistribute this work, contact the repository owner and add an explicit license.
