function m = metrics_median(x, ~)
%METRICS_MEDIAN - Compute the metrics "median" for EPT result analysis.
%   Compute the median of x values, ignoring possible NaNs.
%
%   Syntax
%     m = metrics_median(x)
%
%   Input Arguments
%     'x' - Input data (result of a segmentation and, possibly, erosion)
%       vector
%
%   Output Arguments
%     'm' - Median
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 30 June 2025

m = median(x(:), 'omitnan');

end
