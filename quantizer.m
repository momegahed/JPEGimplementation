function [ quantized ] = quantizer( matrix, mode )
% This function has 2 modes
% the first mode 0 uses table1
% the second mode 1 uses table2
quantizationTable1 = [ %table1
                      1,1,1,1,1,2,2,4;
                      1,1,1,1,1,2,2,4;
                      1,1,1,1,2,2,2,4;
                      1,1,1,1,2,2,4,8;
                      1,1,2,2,2,2,4,8;
                      2,2,2,2,2,4,8,8;
                      2,2,2,4,4,8,8,16;
                      4,4,4,4,8,8,16,16;
                      ];
                  
quantizationTable2 = [ %table2
                      1,2,4,8,16,32,64,128;
                      2,4,4,8   ,16,32,64,128;
                      4,4,8,16,32,64,128,128;
                      8,8,16,32,64,128,128,256;
                      16,16,32,64,128,128,256,256;
                      32,32,64,128,128,256,256,256;
                      64,64,128,128,256,256,256,256;
                      128,128,128,256,256,256,256,256;
                      ];
                  

                  if (mode == 0) %selecting mode and dividing by the corresponding table
                      quantized = round(matrix ./ quantizationTable1); 
                  else
                      quantized = round (matrix ./ quantizationTable2);
                  end
                      
    

end

