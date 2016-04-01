% Demo: Generate sheet of barcodes with random numbers/characters in Code 39 format
%
% Rupert Thomas, April 2016

n = 24;             % number of barcodes to generate
randSeqLength = 6;  % number of characters in each barcode

rng('shuffle');     % very important to do this!
SET = char('0':'9');  % set the character set to randomly draw characters from

barcode_strings = SET(ceil(10*rand(n,randSeqLength)));  % generate n random strings, by randomly sampling from the set

barWidth = 10;   % pixels
barHeight = 100; % pixels
appendTerminationMarkers = true;    % set to true to add the '*' termination markers at the begining and end of the barcode

figure;
barcodeArray = {};
    
for i=1:n
    % Generate a logical array containing the barcode
    barcodeArray{i} = generateBarcodeCode39(barcode_strings(i,:), barWidth, barHeight, appendTerminationMarkers);

    % Generate an image of the barcode
    subplot(8,3,i); subimage(~barcodeArray{i}); % Have to NOT the array, other wise MATLAB displays 1 as black and 0 as white
    title(barcode_strings(i,:)); axis off;
    set(gca,'XTickLabel','');
    set(gca,'YTickLabel','');
    set(gca,'box','off');
end

