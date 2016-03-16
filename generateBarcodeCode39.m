function barcodeArray = generateBarcodeCode39(input, barWidth, barHeight, appendTerminationMarkers)
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
if ~exist('appendTerminationMarkers','var')
    appendTerminationMarkers = true;
end

% Send each character from the input to be encoded
bitString = '';
for i = 1:length(input)
    bitString = [bitString,encodeCharacter(input(i))];
end

% Stop/stop characters
if appendTerminationMarkers
    bitString = [encodeCharacter('*'),bitString,encodeCharacter('*')]; 
end

% Convert string to logical vector
logicalVector = logical(bitString(:)'-'0');    % Thanks Mischa Kim

% 'Stretch' out to required bar width
logicalVector_t = logicalVector';
fullBarWidth = repmat(logicalVector_t(:),1,barWidth)';

% 'Stretch' out to required bar height
barcodeArray = repmat(fullBarWidth(:),1,barHeight)';

