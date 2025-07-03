"""Launch the analysis of EPT results.

@author: Alessandro Arduino
@email: a.arduino@inrim.it
@date: 2 July 2025
"""

from python_src.analysis import run_analysis

working_directory = "example"
input_filename = "a"
dataset_name = "a"

run_analysis(working_directory, input_filename, dataset_name)
