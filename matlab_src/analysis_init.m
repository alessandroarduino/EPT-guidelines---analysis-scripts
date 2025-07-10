function analysis_init()
%ANALYSIS_INIT - Initialize the environment for EPT result analysis.
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

global list_of_metrics;
global erosion_levels;

list_of_metrics = ["mean", "std", "median", "iqr", "rmse", "nrmse"];
erosion_levels = [0, 2, 4];

addpath('./matlab_src/colormaps/');
addpath('./matlab_src/metrics/');

end
