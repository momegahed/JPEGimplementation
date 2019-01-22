%{
Name : Mohamed Megahed
ID : 201500480

please Allow the code a few minutes to run ( depending on the running
device took less than 5min on a core i7 fourth generation PC
%}
clear;
clc;
inputImage = double(imread('Einstein.jpg','jpeg')); % reading input photo
blocks = ImageDivider(inputImage); %calling ImageDivider to divide the input photo to 8x8 blocks
outputblocks0 = blocks; % saved for later to output
outputblocks1 = blocks; % saved for later to output
%%
%Encoding
totalzigzag0 = []; % variables to hold the total stream of all blocks after zigzag traversing each block
totalzigzag1 = [];
for i = 1 : numel(blocks)  % here we are looping on each block performing DCT then dividing it by the corresponding quantization table
                           % then we zigzag traverse it and add it to the
                           % total zigzag variables
                           
dct_block = DCT(blocks{i}); % calling DCT function
quantized0 = quantizer(dct_block,0); % calling quantizer function
quantized1 = quantizer(dct_block,1);
zigzag0 = zigZag(quantized0);% calling zigzag function
zigzag1 = zigZag(quantized1);
totalzigzag0 = [totalzigzag0  zigzag0]; %concatenating zig-zags 
totalzigzag1 = [totalzigzag1  zigzag1];

end
% run length encoding
RLE0 = runLengthEncoder(totalzigzag0)';
RLE1 = runLengthEncoder(totalzigzag1)';
%huffman encoding

bins0 = unique(RLE0); % getting unique symbols
count0 = histc(RLE0, bins0); % counting occurances
p0 = count0/ numel(RLE0); % probabilities
dict0 =huffmandict(bins0,p0); % dictionary
huffman0= huffmanenco(RLE0,dict0); 

bins1 = unique(RLE1); % getting unique symbols
count1 = histc(RLE1, bins1); % counting occurances
p1 = count1/ numel(RLE1); % probabilities
dict1 =huffmandict(bins1,p1); % dictionary
huffman1= huffmanenco(RLE1,dict1); 

%%
%Decoding
%huffman decoding
huffman0_decoded = huffmandeco(huffman0,dict0);
huffman1_decoded = huffmandeco(huffman1,dict1);
% RLE decoding
RLE0_decoded = runLengthDecoder(huffman0_decoded,length(totalzigzag0));
RLE1_decoded = runLengthDecoder(huffman1_decoded,length(totalzigzag1));

% reconstruction blocks

for j = 0:1:numel(outputblocks0)-1
outputblocks0{j+1} = invzigzag(RLE0_decoded(j*64 + 1:j*64 + 64),8,8); %we inverse zigzag traverse the decoded stream
outputblocks1{j+1} = invzigzag(RLE1_decoded(j*64 + 1:j*64 + 64),8,8); % and allocate the array to the corresponding block

outputblocks0{j+1} = dequantizer(outputblocks0{j+1},0); % dequantization by multiplying by the tables
outputblocks1{j+1} = dequantizer(outputblocks1{j+1},1);

outputblocks0{j+1} = IDCT(outputblocks0{j+1}); % performing IDCT using IDCT function
outputblocks1{j+1} = IDCT(outputblocks1{j+1});

end
%%
% Concatenating blocks
for k = 0:length(blocks) - 1 % concatenating the blocks per columns
outImage0{k+1} = cat(1,outputblocks0{length(blocks)*k+1:length(blocks)*k+length(blocks)});

outImage1{k+1} = cat(1,outputblocks1{length(blocks)*k+1:length(blocks)*k+length(blocks)});
end
outImage0 = cat(2,outImage0{1:42}); % concatenating columns
outImage1 = cat(2,outImage1{1:42});

outImage0 = uint8(outImage0);
outImage1 = uint8(outImage1);
%%
%outputting,printing, and plotting
fprintf('Table 1 RLE compression Ratio :%f\n',length(totalzigzag0)/length(RLE0));
fprintf('Table 2 RLE compression Ratio :%f\n',length(totalzigzag1)/length(RLE1));
fprintf('Table 2 is much more efficient regarding compression. However, that comes at the price of more data loss\n');
imwrite(outImage0, 'Compressed_Image_Table1.jpg','jpeg');
imwrite(outImage1, 'Compressed_Image_Table2.jpg','jpeg');
figure();
subplot(2,1,1);
imshow(uint8(inputImage));
subplot(2,1,2); 
imshow(uint8(outImage1));
