figuresDir = fullfile(working_directory, 'figures');
xlsxDir    = fullfile(working_directory, 'xlsx');
csvDir     = fullfile(working_directory, 'csv');
if ~exist(figuresDir, 'dir'), mkdir(figuresDir); end
if ~exist(xlsxDir,    'dir'), mkdir(xlsxDir);    end
if ~exist(csvDir,     'dir'), mkdir(csvDir);     end

for s = 1:numel(suffixes)
    base   = [input_filename suffixes{s}];
    pngOld = fullfile(working_directory, [base '.png']);
    xlsxOld= fullfile(working_directory, [base '.xlsx']);
    if isfile(pngOld)
        movefile(pngOld, fullfile(figuresDir, [base '.png']));
    end
    if isfile(xlsxOld)
        movefile(xlsxOld, fullfile(xlsxDir,    [base '.xlsx']));
    end
end

for s = 1:numel(suffixes)
    xlsxFile = fullfile(xlsxDir, [input_filename suffixes{s} '.xlsx']);
    if ~isfile(xlsxFile)
        warning('Missing XLSX, skipping: %s', xlsxFile);
        continue
    end

    % get all sheet names
    allSheets = sheetnames(xlsxFile);

    for sh = 1:numel(allSheets)
        sheet     = allSheets{sh};
        % read this sheet by name
        T         = readtable(xlsxFile, 'Sheet', sheet);

        % ─── round ALL numeric columns to 3 significant digits ─────────────
        vars = T.Properties.VariableNames;
        for i = 1:numel(vars)
            col = T.(vars{i});
            if isnumeric(col)
                y = zeros(size(col));            % output array
                idx = col~=0 & ~isnan(col);      % non-zero entries
                mags = floor(log10(abs(col(idx))));  % order of magnitude
                dp   = 3 - 1 - mags;              % decimal places per element
                y(idx) = arrayfun(@(x, d) round(x, d), col(idx), dp);
                % zeros and NaNs remain zero/NaN
                T.(vars{i}) = y;
            end
        end
        % ──────────────────────────────────────────────────────────────────

        % sanitize sheet name: all non‐alphanumerics -> '_', collapse multiples, trim
        safeSheet = regexprep(sheet, '[^0-9A-Za-z]', '_');    % spaces, punctuation -> '_'
        safeSheet = regexprep(safeSheet, '_+', '_');          % collapse runs of '_'
        safeSheet = regexprep(safeSheet, '^_|_$', '');        % trim leading/trailing '_'
        if numel(safeSheet) > 32
            safeSheet = safeSheet(1:32);
        end

        % write to csv/<base>_<sheet>.csv
        csvFile = fullfile(csvDir, ...
                  sprintf('%s%s_%s.csv', ...
                          input_filename, suffixes{s}, safeSheet));
        writetable(T, csvFile);
        fprintf('Converted sheet "%s" -> "%s"\n', sheet, csvFile);
    end
end