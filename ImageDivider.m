function [ blocks ] = ImageDivider( image )
%it divides any image to 8x8 blocks
[r,c] = size(image); % getting the size of the image
blocks = mat2cell(image, 8 * ones(1,r/8), 8 * ones(1,c/8)); % reconstruction in a cell matrix with 8x8 blocks

end

