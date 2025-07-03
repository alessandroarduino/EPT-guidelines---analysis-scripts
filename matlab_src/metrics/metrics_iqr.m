function m = metrics_iqr(x, ~)
%METRICS_IQR - Compute the metrics "iqr" for EPT result analysis.
%   Compute the interquartile range of x values, ignoring possible NaNs.
%
%   Syntax
%     m = metrics_iqr(x)
%
%   Input Arguments
%     'x' - Input data (result of a segmentation and, possibly, erosion)
%       vector
%
%   Output Arguments
%     'm' - Interquartile range (according to Hazen's formula)
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 30 June 2025

m = iqr(x(:));

end
