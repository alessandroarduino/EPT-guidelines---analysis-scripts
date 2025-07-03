function m = metrics_mean(x, ~)
%METRICS_MEAN - Compute the metrics "mean" for EPT result analysis.
%   Compute the arithmetic mean of x values, ignoring possible NaNs.
%
%   Syntax
%     m = metrics_mean(x)
%
%   Input Arguments
%     'x' - Input data (result of a segmentation and, possibly, erosion)
%       vector
%
%   Output Arguments
%     'm' - Arithmetic mean
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 30 June 2025

m = mean(x(:), 'omitnan');

end
