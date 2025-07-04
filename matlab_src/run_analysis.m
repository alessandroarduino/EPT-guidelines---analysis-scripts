function run_analysis(working_directory, input_filename, dataset_name)
%RUN_ANALYSIS Run the complete analysis procedure and export the results.
%   Input and output will take place in the working directory.
%
%   Syntax
%     run_analysis(working_directory, input_filename, dataset_name)
%
%   Input Arguments
%     'working_directory' - Address of the folder where I/O will take place
%       string
%     'input_filename' - Name of the Matlab file with the EPT results,
%     without the extension .mat. The results must be stored in variables
%     named 'cond' and 'perm', for electrical conductivity and relative
%     permittivity, respectively. The analysis results will be stored in
%     .xlsx files with the same name and appendix '_cond' or '_perm'
%       string
%     'dataset_name' - Name of the dataset used for testing
%       string
%
%   @author: Alessandro Arduino, Ilias Giannakopoulos
%   @email: a.arduino@inrim.it, Ilias.Giannakopoulos@nyulangone.org
%   @date: 1 July 2025

% Initialize the environment for the EPT result analysis
analysis_init()

% Load the EPT results
address_root = sprintf('%s/%s', working_directory, input_filename);
address = sprintf('%s.mat', address_root);
load(address);

%Load the reference data
dataset_reference = get_dataset_reference(dataset_name);

count = 0;
quantities = ["cond", "perm"];
for quantity = quantities
    if exist(quantity, 'var')
        count = count + 1;
        
        %Perform the analysis
        command = sprintf('perform_analysis(%s, dataset_reference, quantity)', quantity);
        results = eval(command);

        % Export the results to xlsx file
        address = sprintf('%s_%s.xlsx', address_root, quantity);
        n_tables = length(results);
        for idx = 1:n_tables
            tissue = dataset_reference.tissue_names{idx};
            writetable(results{idx}, address, 'Sheet',tissue);
        end

        % Print the results to the command window in table format
        fprintf('\n--- Analysis Results for %s ---\n', upper(quantity));
        for idx = 1:n_tables
            tissue = dataset_reference.tissue_names{idx};
            fprintf('\nTissue: %s\n', tissue);
            disp(results{idx});
        end

    end
end

% If the EPT results are missing from the input file, warn the user
if count == 0
    fprintf('--- No results available for the analysis! ---\n')
    fprintf('--- Check the README for the input requirements! ---\n')
end

% Terminate the environment for the EPT result analysis
analysis_finalize();

end
