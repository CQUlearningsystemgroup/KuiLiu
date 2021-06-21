
clear
close all;
clc

addpath('src','Image','main', 'allcode', 'Set5');

filename = 'boats.tif';
Image = imread(filename);
Image = uint16(Image);
Image = imresize(Image, [544, 544]); % Resizing of YOLO

%%%%%%%%%%%%%  Setting
bits = 4;              % Quantization Bit-Depth
CR = 0.32;             % Compression rate
[I_line,I_row] = size(Image(:,:,1));
CR_line = ceil(256 * CR);  

%%%%%%%%%%%%%  Build compresssion matrix
% CCN-YOLO
CCN = ccn(CR_line, 1);
[CCN_recons,sim1, huffman_cr] = recons4(CCN,Image, bits);


%%%%%%%%%% Print results
fprintf('Image name: %s\n',filename);
fprintf('PSNR: %.2f; SSIM: %.4f;\n', sim1(1,1), sim1(2, 1));



        