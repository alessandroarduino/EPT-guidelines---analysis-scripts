This readme gives an overview of the tool to analyse Magnetic Resonance-based Electrical Properties Tomography (MR-EPT) performances as part of the standardization guidelines for MR-EPT reconstruction standardization, which can be found [here](https://doi.org/10.1002/jmri.70230).

An updated version of this tool can be found in the [Github repository](https://github.com/alessandroarduino/EPT-guidelines---analysis-scripts).

# Overview

This tool performs an analysis of the results (conductivity and permittivity reconstructions) obtained from your MR-EPT method applied to the test datasets provided alongside with the [standardization guideline](https://doi.org/10.1002/jmri.70230).

The repository contains both a Matlab and a Python version of the tool.

# How to Run

## Matlab/Octave

1. Open the file `main.m`.
2. Update the following parameters:
   - `working_directory`: the folder where input/output files are stored.
   - `test_cases`: cell with two columns and as many rows as the test cases to be analysed. In each row, you must report in the first column the name of the dataset used for testing, and in the second column the name of the `.mat` file (without extension) that contains the MR-EPT results in the working directory.
3. Run `main.m`.

### Octave

Warning! Currently the code cannot be run with Octave because of the missing function `writetable` in `tablicious`. Some correction is also needed in the usage of `strel`, because `image` does not support the shape `sphere`.

If using [Octave](https://octave.org/) (>=11.1.0), the following packages are required:

   - [image](https://octave.sourceforge.io/image/index.html) (>=2.20.0)
   - [tablicious](https://github.com/apjanke/octave-tablicious) (>=0.4.7)

### Credits

The used files of colormaps `lipari.mat` and `navia.mat` are from the library of [Scientific color maps](https://doi.org/10.5281/zenodo.8409685) by Fabio Crameri.

## Python

1. Open the file `main.py`.
2. Update the following parameters:
   - `working_directory`: the folder where input/output files are stored.
   - `test_cases`: dictionary of test cases. For each entry of the dictionary, the key contains the name of the dataset you want to use for testing, and the value is the name of the `.mat` file (without extension) that contains the MR-EPT results in the working directory.
3. Run `main.py`.

### Prerequisites

The following packages are needed:
   - [cmcrameri](https://pypi.org/project/cmcrameri/) (>=1.8)
   - [matplotlib](https://matplotlib.org/) (>=3.9.2)
   - [numpy](https://numpy.org) (>=2.1.3)
   - [openpyxl](https://openpyxl.readthedocs.io) (>=3.1.5)
   - [pandas](https://pandas.pydata.org/) (>=2.2.3)
   - [scikit-image](https://scikit-image.org/) (>=0.25.2)
   - [scipy](https://scipy.org) (>=1.15.2)

The package version reported in brackets represents the oldest releases with which the tool has been tested.
Older versions could work as well.

# Input Requirements

The input `.mat` file must contain variables named:
- `cond`: estimated electrical conductivity values
- `perm`: estimated relative electric permittivity values

If one of the two variables is missing, it will simply be skipped during analysis. This enables compatibility with conductivity-only, permittivity-only and full complex-valued methods.

# Output

The results will be exported as `.xlsx` files in the specified working directory and as an output in the workspace. Each file contains the full set of analysis metrics for the corresponding property (`cond` or `perm`), organized by tissue.

# Datasets

This repository provides the scripts to perform the analysis, but not the datasets. You can download the datasets from [this Zenodo repository](https://doi.org/10.5281/zenodo.17879937). In order to have a working analysis tool, you have to copy the content of the folder `1 Input Datasets for your recon method` from the Zenodo repository into the `datasets` folder of this repository.

# Example of standardized report

The result of this analysis can be used to fill the standardized report proposed by the [standardization guideline](https://doi.org/10.1002/jmri.70230).

An example of a standardized report is provided alongside the guidelines and the data used to produce that analysis can be downloaded from the [Zenodo repository](https://doi.org/10.5281/zenodo.17879937), where further details can be found. These data were generated using [EPTlib](https://eptlib.github.io/).
