function dataset_reference = get_dataset_reference(dataset_name)
%GET_DATASET_REFERENCE - Collect the dataset references for EPT analysis.
%   For each test case, the analysis is based on a segmentation of the
%   domain and on a reference value of conductivity and relative
%   permittivity associated with each segment of the domain.
%
%   Syntax
%     dataset_reference = get_dataset_reference(dataset_name)
%
%   Input Arguments
%     'dataset_name' - Name of the dataset used for testing
%       string
%
%   Output Arguments
%     'dataset_reference' - Structure for dataset references with the
%       following fields:
%       | structure field | description                                  |
%       +-----------------+----------------------------------------------+
%       | segmentation    | Image with a label for each segment          |
%       | cond_ref        | Reference conductivity value in each segment |
%       | perm_ref        | Reference rel. permittivity in each segment  |
%       | tissue_names    | Name of each segment (cell of strings)       |
%       structure
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

address = sprintf('./datasets/%s/dataset_reference.mat', dataset_name);
dataset_reference = load(address);

end
