"""Launch the analysis of EPT results.

@author: Alessandro Arduino
@email: a.arduino@inrim.it
@date: 2 July 2025
"""

from python_src.analysis import run_analysis
from python_src.save_output import save_outputs

working_directory = "example"
test_cases = {
    "a": "Brain_sim_healthy_noiseless-out",
    "b": "Brain_sim_healthy_noise-out",
    "c": "Brain_sim_tumor_noiseless-out",
    "d": "Brain_sim_tumor_noise-out",
    "e": "Cylinder_phantom-out",
    "f": "Sphere_phantom-out",
}

for dataset_name, input_filename in test_cases.items():
    run_analysis(working_directory, input_filename, dataset_name)
    save_outputs(working_directory, input_filename)