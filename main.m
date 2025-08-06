%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

working_directory = 'example';
test_cases = {
    'a', 'Brain_sim_healthy_noiseless-out';
    'b', 'Brain_sim_healthy_noise-out';
    'c', 'Brain_sim_tumor_noiseless-out';
    'd', 'Brain_sim_tumor_noise-out';
    'e', 'Cylinder_phantom-out';
    'f', 'Sphere_phantom-out';
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
