function x = get_eroded_segment(image, mask, erosion_level)
%GET_ERODED_SEGMENT - Extract the image values from an eroded segment.
%
%   Syntax
%     x = get_eroded_segment(image, mask, erosion_level)
%
%   Input Arguments
%     'image' - Input data with conductivity or permittivity values
%       matrix | multidimensional array
%     'mask' - Reference mask with the segment shape
%       matrix | multidimensional array
%     'erosion_level' - number of voxels (or pixels) to erode
%       scalar
%
%   Output Arguments
%     'x' - List of values in the segmented and eroded image.
%       vector
%
%   @author: Alessandro Arduino
%   @email: a.arduino@inrim.it
%   @date: 1 July 2025

if erosion_level > 0
    sphere = strel('sphere', erosion_level);
    mask = imerode(mask, sphere);
end

x = image(mask);

end
