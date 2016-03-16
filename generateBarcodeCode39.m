function barcodeArray = generateBarcodeCode39(input, barWidth, barHeight)
% Convert the input string into a logical array, containing a
% barcode in Code 39 format
%
% Rupert Thomas, March 2016
%
% input: string
% barWidth: bar width in pixels, default 3
% barHeight: bar height in pixels, default 10

if ~exist('barWidth','var')
    barWidth = 3;
end
if ~exist('barHeight','var')
    barHeight = 10;
end

% Generate logical array for input sequence
encoded = encodeStringCode39(input);

% 'Stretch' out to required bar width
encoded_t = encoded';
fullBarWidth = repmat(encoded_t(:),1,barWidth)';

% 'Stretch' out to required bar height
barcodeArray = repmat(fullBarWidth(:),1,barHeight)';

