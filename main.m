%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

working_directory = 'example';
test_cases = {
    'A Simulated Brain without tumor without noise', 'A_Brain_sim_healthy_noiseless-out';
    'B Simulated Brain without tumor with noise', 'B_Brain_sim_healthy_noise-out';
    'C Simulated Brain with tumor without noise', 'C_Brain_sim_tumor_noiseless-out';
    'D Simulated Brain with tumor with noise', 'D_Brain_sim_tumor_noise-out';
    'E Measured Sphere phantom', 'E_Sphere_phantom-out';
    'F Measured Cylindrical phantom', 'F_Cylinder_phantom-out';
};

% create subfolders if needed

suffixes = {'_cond', '_perm'};

for idx = 1:size(test_cases, 1)
    input_filename = test_cases{idx, 2};

    addpath('matlab_src/');
    run_analysis(working_directory, input_filename, test_cases{idx,1});
    save_outputs
    rmpath('matlab_src/');

end
