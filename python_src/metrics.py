"""Collection of metrics for the EPT result analysis.

This file requires `numpy`.

@author: Alessandro Arduino
@email: a.arduino@inrim.it
@date: 2 July 2025
"""

import numpy as np


def metrics_mean(x, x_ref=None):
    """Compute the metrics "mean" for EPT result analysis.

    Compute the arithmetic mean of x values, ignoring possible NaNs.

    Parameters
    ----------
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)

    Returns
    -------
    scalar
        Arithmetic mean
    """
    m = np.nanmean(x)
    return m


def metrics_std(x, x_ref=None):
    """Compute the metrics "std" for EPT result analysis.

    Compute the standard deviation of x values, ignoring possible NaNs.

    Parameters
    ----------
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)

    Returns
    -------
    scalar
        Standard deviation (from unbiased sample variance)
    """
    m = np.nanstd(x, ddof=1)
    return m


def metrics_median(x, x_ref=None):
    """Compute the metrics "median" for EPT result analysis.

    Compute the median of x values, ignoring possible NaNs.

    Parameters
    ----------
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)

    Returns
    -------
    scalar
        Median
    """
    m = np.nanmedian(x)
    return m


def metrics_iqr(x, x_ref=None):
    """Compute the metrics "iqr" for EPT result analysis.

    Compute the interquartile range of x values, ignoring possible NaNs.

    Parameters
    ----------
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)

    Returns
    -------
    scalar
        Interquartile range (according to Hazen's formula)
    """
    p75, p25 = np.percentile(x, [75, 25], method='hazen')
    m = p75 - p25
    return m


def metrics_rmse(x, x_ref):
    """Compute the metrics "rmse" for EPT result analysis.

    Compute the root mean square error of x values, ignoring possible NaNs.

    Parameters
    ----------
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)
    x_ref : scalar
        Reference value

    Returns
    -------
    scalar
        Root mean square error
    """
    x = x[np.isfinite(x)]
    n = x.size
    m = np.linalg.norm(x - x_ref, ord=2) / np.sqrt(n)
    return m


def metrics_nrmse(x, x_ref):
    """Compute the metrics "nrmse" for EPT result analysis.

    Compute the normalized RMSE of x values, ignoring possible NaNs.

    Parameters
    ----------
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)
    x_ref : scalar
        Reference value

    Returns
    -------
    scalar
        Normalized root mean square error
    """
    m = metrics_rmse(x, x_ref) / x_ref
    return m
