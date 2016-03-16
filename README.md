# barcode-39-generator-MATLAB
Convert strings into barcodes encoded using the Code 39 format

## Files:
### generateBarcodeCode39.m
Converts the string input into a logical array containing the barcode. Optional parameters for:
barWidth : integer, the bar width in units (effectively pixels), default 3
barHeight : integer, the bar height in units (effectively pixels), default 10
appendTerminationMarkers : boolean, whether to append the '*' at the begining and end of the code, default true

### encodeCharacter.m
Does the conversion of individual characters into the binary-like sequence of 1's and 0's. Has a fixed 3:1 ratio, width of thick bars to thin.

### demo.m
Runs generateBarcodeCode39.m with an example input, and displays the result in a MATLAB figure
