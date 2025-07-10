function colormap = get_color_map(quantity)
%GET_COLOR_MAP - Select the correct colormap depending on the quantity to
%   be plotted.
%
%   Syntax
%     colormap = get_color_map(quantity)
%
%   Input Arguments
%     'quantity' - Name of the analysed quantity
%       'cond' | 'perm'
%
%   Output Arguments
%     'colormap' - Palette associated with the considered quantity
%       Colormap
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 10 July 2025

if quantity == 'cond'
    load('lipari.mat');
    colormap = lipari;
else
    load('navia.mat');
    colormap = navia;
end

end
