%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

working_directory = 'example';
input_filename = 'a';
dataset_name = 'a';

addpath('matlab_src/');
run_analysis(working_directory, input_filename, dataset_name);
rmpath('matlab_src/');
