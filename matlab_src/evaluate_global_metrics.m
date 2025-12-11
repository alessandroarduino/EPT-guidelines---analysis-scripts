function [m, m99] = evaluate_global_metrics(image, dataset_reference, quantity)
%EVALUATE_GLOBAL_METRICS - Apply the global metrics to the data for EPT
%   result analysis.
%
%   The global metrics is a global NRMSE evaluated on the entire image
%   excluded the background and possible NaNs.
%
%   Syntax
%     m = evaluate_global_metrics(image, dataset_reference, quantity)
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
%     'm' - Global NRMSE
%       scalar
%     'm99' - NRMSE of the best 99 % of voxels
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 10 July 2025

mask = dataset_reference.segmentation > 0 & isfinite(image);
x = image(mask);

x_ref = generate_reference_map(dataset_reference, quantity);
x_ref = x_ref(mask);

error = abs(x - x_ref);
m = norm(error, 2) / norm(x_ref, 2);

mask = error < prctile(error, 99);
m99 = norm(error(mask), 2) / norm(x_ref(mask), 2);

end
