function results = perform_analysis(image, dataset_reference, quantity)
%PERFORM_ANALYSIS - Perform the whole analysis for a quantity map.
%   The analysed quantity can be both conductivity and rel. permittivity.
%
%   Syntax
%     table = perform_analysis(image, dataset_reference, quantity)
%
%   Input Arguments
%     'image' - Input data with conductivity or permittivity values
%       matrix | multidimensional array
%     'dataset_reference' - Structure for dataset references
%       structure
%     'quantity' - Name of the analysed quantity
%       'cond' | 'perm'
%
%   Output Arguments
%     'results' - Dictionary of tables with all the analysis results
%       dictionary of tables
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

global list_of_metrics;
global erosion_levels;

n_labels = max(dataset_reference.segmentation(:));
n_erosions = length(erosion_levels);
n_metrics = length(list_of_metrics);

table_size = [n_erosions, n_metrics+1];
table_type = repmat("double", 1, table_size(2));
table_column_name = ["erosion level", list_of_metrics];

results = cell(n_labels, 1);

for label = 1:n_labels
    % get the mask with the segment shape
    mask = dataset_reference.segmentation == label;
    % get the reference value of the quantity of interest
    command = sprintf('dataset_reference.%s_ref(label)', quantity);
    x_ref = eval(command);

    results{label} = table('Size',table_size, 'VariableTypes',table_type);
    results{label}.Properties.VariableNames = table_column_name;

    for row = 1:n_erosions
        erosion_level = erosion_levels(row);
        results{label}.('erosion level')(row) = erosion_level;

        x = get_eroded_segment(image, mask, erosion_level);

        for metrics = list_of_metrics
            m = apply_metrics(metrics, x, x_ref);
            results{label}.(metrics)(row) = m;
        end
    end
end

end
