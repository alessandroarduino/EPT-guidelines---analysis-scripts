function m = apply_metrics(metrics, x, x_ref) %#ok<INUSD>
%APPLY_METRICS - Apply the metrics to the data for EPT result analysis.
%   Depending on the selected metrics, 'x_ref' can be used or not.
%
%   Syntax
%     m = apply_metrics(metrics, x)
%     m = apply_metrics(metrics, x, x_ref)
%
%   Input Arguments
%     'metrics' - Name of the metrics to be applied
%       string
%     'x' - Input data (result of a segmentation and, possibly, erosion)
%       vector
%     'x_ref' - Reference value
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

function_name = sprintf('metrics_%s', metrics);

if nargin < 3
    command = sprintf('%s(x)', function_name);
else
    command = sprintf('%s(x, x_ref)', function_name);
end

m = eval(command);

end
