% Demo: Generate and show a barcode in Code 39 format
%
% Rupert Thomas, March 2016

testString = '123456';

barWidth = 3;   % pixels
barHeight = 100; % pixels
appendTerminationMarkers = false;

% Generate a logical array containing the barcode
barcodeArray = generateBarcodeCode39(testString, barWidth, barHeight, appendTerminationMarkers);

% Generate an image of the barcode
figure;
imshow(~barcodeArray);  % Have to NOT the array, other wise MATLAB displays 1 as black and 0 as white