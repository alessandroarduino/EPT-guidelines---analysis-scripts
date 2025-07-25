function ref_map = generate_reference_map(dataset_reference, quantity)
%GENERATE_REFERENCE_MAP - Combine the segmentation and the reference values
%   in a reference map.
%
%   Syntax
%     ref_map = generate_reference_map(dataset_reference, quantity)
%
%   Input Arguments
%     'dataset_reference' - Structure for dataset references
%       structure
%     'quantity' - Name of the analysed quantity
%       'cond' | 'perm'
%
%   Output Arguments
%     'ref_map' - Reference map
%       np.array
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 10 July 2025

ref_map = dataset_reference.segmentation;

command = sprintf('dataset_reference.%s_ref', quantity);
x_ref = eval(command);

for label = 1:length(x_ref)
    mask = dataset_reference.segmentation == label;
    ref_map(mask) = x_ref(label);
end

end
