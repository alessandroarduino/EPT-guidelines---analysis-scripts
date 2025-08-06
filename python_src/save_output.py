import os
import shutil
import math
import pandas as pd
import re


def round_sig(x, sig=3):
    """
    Round x to sig significant digits.
    """
    try:
        if pd.isna(x) or x == 0:
            return x
        dp = sig - 1 - math.floor(math.log10(abs(x)))
        return round(x, dp)
    except Exception:
        return x


def make_safe_sheet_name(sheet_name, max_len=32):
    """
    Convert a sheet name into a filesystem-safe identifier:
    - Replace non-alphanumeric characters with underscore
    - Collapse multiple underscores
    - Trim leading/trailing underscores
    - Truncate to max_len characters
    """
    # replace non-alphanumeric with underscore
    safe = re.sub(r"[^0-9A-Za-z]", "_", sheet_name)
    # collapse multiple underscores
    safe = re.sub(r"_+", "_", safe)
    # trim leading/trailing underscores
    safe = safe.strip("_")
    # truncate
    if len(safe) > max_len:
        safe = safe[:max_len]
    return safe


def save_outputs(working_directory, input_filename, suffixes=None):
    """
    Move generated PNG and XLSX files into subdirectories, then convert each
    sheet of each XLSX into a CSV with values rounded to 3 significant digits.

    Args:
      working_directory (str): Path to the base folder.
      input_filename    (str): Base name of the dataset (without suffix).
      suffixes          (list): List of suffixes, e.g. ['_cond', '_perm'].
    """
    if suffixes is None:
        suffixes = ['_cond', '_perm']

    # Create subfolders
    figures_dir = os.path.join(working_directory, 'figures')
    xlsx_dir    = os.path.join(working_directory, 'xlsx')
    csv_dir     = os.path.join(working_directory, 'csv')
    os.makedirs(figures_dir, exist_ok=True)
    os.makedirs(xlsx_dir,    exist_ok=True)
    os.makedirs(csv_dir,     exist_ok=True)

    # Move PNG and XLSX into their subfolders
    for suf in suffixes:
        base    = f"{input_filename}{suf}"
        png_old = os.path.join(working_directory, f"{base}.png")
        xlsx_old= os.path.join(working_directory, f"{base}.xlsx")
        if os.path.isfile(png_old):
            shutil.move(png_old, os.path.join(figures_dir, f"{base}.png"))
        if os.path.isfile(xlsx_old):
            shutil.move(xlsx_old, os.path.join(xlsx_dir,    f"{base}.xlsx"))

    # Convert each sheet of each XLSX to its own CSV
    for suf in suffixes:
        xlsx_path = os.path.join(xlsx_dir, f"{input_filename}{suf}.xlsx")
        if not os.path.isfile(xlsx_path):
            print(f"Missing XLSX, skipping: {xlsx_path}")
            continue

        # Read all sheet names
        xls = pd.ExcelFile(xlsx_path)
        for sheet_name in xls.sheet_names:
            # Read sheet
            df = pd.read_excel(xlsx_path, sheet_name=sheet_name)
            # Round numeric columns
            for col in df.columns:
                if pd.api.types.is_numeric_dtype(df[col]):
                    df[col] = df[col].map(round_sig)
            # Sanitize sheet name
            safe_sheet = make_safe_sheet_name(sheet_name)
            csv_path = os.path.join(
                csv_dir,
                f"{input_filename}{suf}_{safe_sheet}.csv"
            )
            df.to_csv(csv_path, index=False)
            print(f"Converted sheet '{sheet_name}' -> '{csv_path}'")
