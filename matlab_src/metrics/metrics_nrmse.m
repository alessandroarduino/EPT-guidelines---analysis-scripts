function m = metrics_nrmse(x, x_ref)
%METRICS_NRMSE - Compute the metrics "nrmse" for EPT result analysis.
%   Compute the normalized RMSE of x values, ignoring possible NaNs.
%
%   Syntax
%     m = metrics_rmse(x)
%
%   Input Arguments
%     'x' - Input data (result of a segmentation and, possibly, erosion)
%       vector
%     'x_ref' - Reference value
%       scalar
%
%   Output Arguments
%     'm' - Normalized root mean square error
%       scalar
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 30 June 2025

m = rmse(x(:), x_ref, 'omitnan') / x_ref;

end
