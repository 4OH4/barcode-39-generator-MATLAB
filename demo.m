% Demo: Generate and show a barcode in Code 39 format

testString = 'fooBar';

barWidth = 5;   % pixels
barHeight = 50; % pixels

% Generate a logical array containing the barcode
barcodeArray = generateBarcodeCode39(testString, barWidth, barHeight);

% Generate an image of the barcode
figure;
imshow(barcodeArray);