
clear
close all;
clc

addpath('src','Image','main', 'allcode', 'Set5');

Image = imread('boats.tif');
Image = uint16(Image);
Image = imresize(Image, [544, 544]);

%%%%%%%%%%%%%  Setting
bits = 5;              % Quantization Bit-Depth
CR = 0.32;             % Compression rate
[I_line,I_row] = size(Image(:,:,1));
CR_line = ceil(256 * CR);  

%%%%%%%%%%%%%  Build compresssion matrix
% CCN-YOLO
CCN = ccn(CR_line, 1);
[CCN_recons,sim1, huffman_cr] = recons3(CCN,Image, bits);


%%%%%%%%%% Draw results
load pos.mat     
subplot(1,2,1);
imshow(uint8(Image)),title('Input Image');

subplot(1,2,2);
a1 = num2str(sim1(1,1));
a2 = num2str(sim1(2,1));
a3 = strcat('CCN',' PSNR=',a1,' SSIM=',a2);
imshow(CCN_recons,'border','tight'),title(a3);

        