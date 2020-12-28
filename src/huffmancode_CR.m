function [cr] = huffmancode_CR(Image)

% calculate the frequency of each pixel
[frequency,pixelValue] = imhist(Image());

% sum all the frequencies
tf = sum(frequency) ;

% calculate the frequency of each pixel
probability = frequency ./ tf ;

% create a dictionary
dict = huffmandict(pixelValue,probability);

% get the image pixels in 1D array
imageOneD = Image(:) ;

% encoding
testVal = imageOneD ;
encodedVal = huffmanenco(testVal,dict);

kb =  8 * 1024 ;
origin = numel(de2bi(testVal))/kb;
compression = numel(encodedVal)/kb;

cr = compression/origin;

