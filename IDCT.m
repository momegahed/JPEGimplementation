function [ outputIDCT ] = IDCT( dctImage )
%IDCT This function outputs IDCT for an 8x8 block

[xlength , ylength] = size(dctImage);% getting block size

outputIDCT = zeros(xlength,ylength); %perparing output variable

for x = 0:xlength - 1     % looping on x,y
    for y =0:ylength - 1  % to get each point in the original block y(x,y)
        for u = 0:xlength -1      % looping on x,y and summing the coeffs
            for v = 0:ylength - 1 % the nested loops represents the double summation in the analytical formula
                outputIDCT(x+1,y+1) = outputIDCT(x+1,y+1)+ dctImage(u+1,v+1).*cos(((2*x+1)*u.*pi)/(2*xlength)).*cos(((2*y+1)*v.*pi)/(2*ylength));
            end
        end
       
    end
end