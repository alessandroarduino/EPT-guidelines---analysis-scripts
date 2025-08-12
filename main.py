"""Launch the analysis of EPT results.

@author: Alessandro Arduino
@email: a.arduino@inrim.it
@date: 2 July 2025
"""

from python_src.analysis import run_analysis
from python_src.save_output import save_outputs

working_directory = "example"
test_cases = {
    "A Simulated Brain without tumor without noise": "A_Brain_sim_healthy_noiseless-out",
    "B Simulated Brain without tumor with noise": "B_Brain_sim_healthy_noise-out",
    "C Simulated Brain with tumor without noise": "C_Brain_sim_tumor_noiseless-out",
    "D Simulated Brain with tumor with noise": "D_Brain_sim_tumor_noise-out",
    "E Measured Sphere phantom": "E_Sphere_phantom-out",
    "F Measured Cylindrical phantom": "F_Cylinder_phantom-out",
}

for dataset_name, input_filename in test_cases.items():
    run_analysis(working_directory, input_filename, dataset_name)
    save_outputs(working_directory, input_filename)
