"""Collection of functions for the EPT result analysis.

This file requires `numpy`, `scipy`, `skimage`, `pandas`, `openpyxl`.

@author: Alessandro Arduino
@email: a.arduino@inrim.it
@date: 2 July 2025
"""

import numpy as np
import os
import scipy.io as sio
import skimage.morphology as morpho
import pandas as pd

from .metrics import *

list_of_metrics = ["mean", "std", "median", "iqr", "rmse", "nrmse"]
erosion_levels = [0, 2, 4]


def apply_metrics(metrics, x, x_ref=None):
    """Apply the metrics to the data for EPT result analysis.

    Depending on the selected metrics, 'x_ref' can be used or not.

    Parameters
    ----------
    metrics : string
        Name of the metrics to be applied
    x : np.array
        Input data (result of a segmentation and, possibly, erosion)
    x_ref : scalar | None (default)
        Reference value

    Returns
    -------
    scalar
        Evaluated metrics
    """
    function_name = f"metrics_{metrics}"

    if x_ref is None:
        command = f"{function_name}(x)"
    else:
        command = f"{function_name}(x, x_ref)"

    m = eval(command)

    return m


def get_dataset_reference(dataset_name):
    """Collect the dataset references for EPT analysis.

    For each test case, the analysis is based on a segmentation of the
    domain and on a reference value of conductivity and relative
    permittivity associated with each segment of the domain.

    Parameters
    ----------
    dataset_name : string
        Name of the dataset used for testing

    Returns
    -------
    dataset_reference : dict
        Dictionary for dataset references with the following fields:
          | dictionary field | description                                  |
          +-----------------+-----------------------------------------------+
          | segmentation     | Image with a label for each segment          |
          | cond_ref         | Reference conductivity value in each segment |
          | perm_ref         | Reference rel. permittivity in each segment  |
          | tissue_names     | Name of each segment                         |
    """
    address = os.path.join("datasets", dataset_name, "dataset_reference.mat")
    dataset_reference = sio.loadmat(address)
    return dataset_reference


def get_eroded_segment(image, mask, erosion_level):
    """Extract the image values from an eroded segment.

    Parameters
    ----------
    image : np.array
        Input data with conductivity or permittivity values
    mask : np.array
        Reference mask with the segment shape
    erosion_level : scalar
        Number of voxels (or pixels) to erode

    Returns
    -------
    x : np.array
        List of values in the segmented and eroded image.
    """
    if erosion_level > 0:
        sphere = morpho.ball(erosion_level)
        mask = morpho.erosion(mask, sphere)

    x = image[mask]

    return x


def perform_analysis(image, dataset_reference, quantity):
    """Perform the whole analysis for a quantity map.

    The analysed quantity can be both conductivity and rel. permittivity.

    Parameters
    ----------
    image : np.array
        Input data with conductivity or permittivity values
    dataset_reference : dict
        Structure for dataset references
    quantity : "cond" | "perm"
        Name of the analysed quantity

    Returns
    -------
    results : list of pd.DataFrame
        List of tables with all the analysis results
    """
    n_labels = np.max(dataset_reference["segmentation"])
    n_erosions = len(erosion_levels)
    n_metrics = len(list_of_metrics)

    table_size = [n_erosions, n_metrics+1]
    table_column_name = ["erosion level",] + list_of_metrics

    results = []

    for label in range(n_labels):
        # get the mask with the segmented shape
        mask = dataset_reference["segmentation"] == label+1
        # get the reference value of the quantity of interest
        key_ref = f"{quantity}_ref"
        x_ref = dataset_reference[key_ref][label]

        results.append(
            pd.DataFrame(np.zeros(table_size), columns=table_column_name))
        for row in range(n_erosions):
            erosion_level = erosion_levels[row]
            results[label].loc[row, "erosion level"] = erosion_level

            x = get_eroded_segment(image, mask, erosion_level)

            for metrics in list_of_metrics:
                m = apply_metrics(metrics, x, x_ref)
                results[label].loc[row, metrics] = m

    return results


def run_analysis(working_directory, input_filename, dataset_name):
    """Run the complete analysis procedure and export the results.

    Input and output will take place in the working directory.

    Parameters
    ----------
    working_directory : string
        Address of the folder where I/O will take place
    input_filename : string
        Name of the Matlab file with the EPT results, without the extension.
        The results must be stored in variables named 'cond' and 'perm', for
        electrical conductivity and relative permittivity, respectively. The
        analysis results will be stored in .xlsx files with the same name
        and appendix '_cond' or '_perm'
    dataset_name : string
        Name of the dataset used for testing
    """
    # Load the EPT results
    address_root = os.path.join(working_directory, input_filename)
    address = f"{address_root}.mat"
    EPT_results = sio.loadmat(address)

    # Load the reference data
    dataset_reference = get_dataset_reference(dataset_name)

    quantities = ["cond", "perm"]
    for quantity in quantities:
        if quantity in EPT_results.keys():
            # Perform the analysis
            results = perform_analysis(
                EPT_results[quantity], dataset_reference, quantity)

            # Export the results to xlsx file
            n_tables = len(results)
            address = f"{address_root}_{quantity}.xlsx"
            with pd.ExcelWriter(address) as excel_file:
                for idx in range(n_tables):
                    tissue = dataset_reference["tissue_names"][0][idx][0]
                    results[idx].to_excel(
                        excel_file, sheet_name=tissue, index=False)

            # Print the results to the command window in table format
            print(f"\n--- Analysis Results for {quantity.upper()} ---\n")
            for idx in range(n_tables):
                tissue = dataset_reference["tissue_names"][0][idx][0]
                print(f"\nTissue: {tissue}\n")
                print(results[idx])
