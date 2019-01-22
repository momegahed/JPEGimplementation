function [ outputDCT ] = DCT( inputImage )
%DCT This function outputs DCT for an 8x8 block

[xlength , ylength] = size(inputImage); % getting block size

outputDCT = zeros(xlength,ylength); % preparing output variable

for u = 0:xlength - 1     % looping on u,v to
    for v =0:ylength - 1  %calculate each DCT coeff Y(u,v)
        coeff = 0;
        for x = 0:xlength -1       % looping on x,y and summing the coeffs
            for y = 0:ylength - 1  % the nested loops represents the double summation in the analytical formula
            coeff = coeff + inputImage(x+1,y+1).*cos(((2*x+1)*u.*pi)/(2*xlength)).*cos(((2*y+1)*v.*pi)/(2*ylength)) ;
             end
        end
        if(u==0 && v==0) % dividing y(0,0) by 64
            coeff = coeff/64;
        elseif(u==0 || v ==0) % dividing y(0,:) and y(:,0) by 32
            coeff = coeff/32;
        else
            coeff = coeff/16; % dividing all other elements with 16
        end
        
    outputDCT(u+1,v+1) = coeff;     % adding to output
    end
    end
outputDCT = round(outputDCT); %rounding output
    
end

