function m = metrics_std(x, ~)
%METRICS_STD - Compute the metrics "std" for EPT result analysis.
%   Compute the standard deviation of x values, ignoring possible NaNs.
%
%   Syntax
%     m = metrics_std(x)
%
%   Input Arguments
%     'x' - Input data (result of a segmentation and, possibly, erosion)
%       vector
%
%   Output Arguments
%     'm' - Standard deviation (from unbiased sample variance)
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 30 June 2025

m = std(x(:), 'omitnan');

end
