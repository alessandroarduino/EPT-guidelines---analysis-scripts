# Overview

This tool performs an analysis of the results obtained from Electrical Properties Tomography (EPT) applied to test datasets.

The repository contains both a Matlab and a Python version of the tool.

# How to Run

## Matlab

1. Open the file `main.m`.
2. Update the following parameters:
   - `working_directory`: the folder where input/output files are stored.
   - `input_filename`: the name of the `.mat` file (without extension) that contains the EPT results.
   - `dataset_name`: the name of the dataset used for testing.
3. Run `main.m`.

## Python

1. Open the file `main.py`.
2. Update the following parameters:
   - `working_directory`: the folder where input/output files are stored.
   - `input_filename`: the name of the `.mat` file (without extension) that contains the EPT results.
   - `dataset_name`: the name of the dataset used for testing.
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

The package version reported in brackets represent the oldest releases with which the tool has been tested.
Older versions could work as well.

# Input Requirements

The input `.mat` file must contain variables named:
- `cond`: estimated electrical conductivity values
- `perm`: estimated relative electric permittivity values

If one of the two variables is missing, it will simply be skipped during analysis. This enables compatibility with both conductivity-only methods and full complex-valued methods.

# Output

The results will be exported as `.xlsx` files in the specified working directory and as an output in the workspace. Each file contains the full set of analysis metrics for the corresponding property (`cond` or `perm`), organized by tissue.
