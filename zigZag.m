function [ zigzag ] = zigZag( array )
% this function traverse any array in a zig zag manner
ind = reshape(1:numel(array), size(array));         % indices of elements
ind = fliplr( spdiags( fliplr(ind) ) );             % get the anti-diagonals
ind(:,1:2:end) = flipud( ind(:,1:2:end) );          % reverse order of odd columns
ind(ind==0) = [];                                   % keep non-zero indices

zigzag = array(ind);

end

