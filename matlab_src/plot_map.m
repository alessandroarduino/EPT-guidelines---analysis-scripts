function fig = plot_map(image, dataset_reference, quantity)
%PLOT_MAP - Plot a comparison between the EPT result and the reference
%   image.
%
%   Syntax
%     fig = plot_map(image, dataset_reference, quantity)
%
%   Input Arguments
%     'image' - Input data with conductivity or permittivity values
%       matrix | multidimensional array
%     'dataset_reference' - Structure for dataset references
%       structure
%     'quantity' - Name of the analysed quantity
%       'cond' | 'perm'
%
%   Output Arguments
%     'fig' - Handler to the figure
%       Figure
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 10 July 2025

k0 = floor(size(image, 3) / 2) + 1;
ref_image = generate_reference_map(dataset_reference, quantity);

fig = figure('Units', 'inches', 'Position', [0, 0, 6.5, 3.22]);

if strcmp(quantity,'cond')
    title_quantity = 'cond. (S/m)';
    v_min = 0.0;
    v_max = 2.5;
else
    title_quantity = 'rel. perm. (-)';
    v_min = 30;
    v_max = 100;
end

colormap(get_color_map(quantity));

ax1 = subplot(1, 2, 1, 'Parent', fig);
imagesc(image(:, :, k0));
clim([v_min, v_max]);
title(sprintf('Reconstructed %s', title_quantity));
axis image;

ax2 = subplot(1, 2, 2, 'Parent', fig);
imagesc(ref_image(:, :, k0));
clim([v_min, v_max]);
title(sprintf('Reference %s', title_quantity));
axis image;

h = axes(fig, 'Visible', 'off');
c = colorbar(h, 'Position', [0.93, 0.168, 0.022, 0.7]);
clim([v_min, v_max]);

end
