function result = encodeCharacter(in)
% Encode a single character into the 12-bit sequence for the Code 39
% barcode format. Adds the trailing zero on the end, to make 13 bits.
%
% Rupert Thomas, March 2016
%
% Derived from Barcode Encoder (Code 39 format) by Lakshmi Nair
% http://www.mathworks.com/matlabcentral/fileexchange/49483-barcode-encoder--code-39-format-

assert(ischar(in));
assert(length(in)==1);

codesArray = {
'1010001110111010', '1110100010101110', '1011100010101110', '1110111000101010', ... % 0, 1, 2, 3
'1010001110101110', '1110100011101010', '1011100011101010', '1010001011101110', ... % 4, 5, 6, 7
'1110100010111010', '1011100010111010', '1110101000101110', '1011101000101110', ... % 8, 9, A, B
'1110111010001010', '1010111000101110', '1110101110001010', '1011101110001010', ... % C, D, E, F
'1010100011101110', '1110101000111010', '1011101000111010', '1010111000111010', ... % G, H, I, J
'1110101010001110', '1011101010001110', '1110111010100010', '1010111010001110', ... % K, L, M, N
'1110101110100010', '1011101110100010', '1010101110001110', '1110101011100010', ... % O, P, Q, R
'1011101011100010', '1010111011100010', '1110001010101110', '1000111010101110', ... % S, T, U, V
'1110001110101010', '1000101110101110', '1110001011101010', '1000111011101010', ... % W, X, Y, Z
'1000101011101110', '1110001010111010', '1000111010111010', '1000100010001010', ... % -, ., (space), $
'1000100010100010', '1000101000100010', '1010001000100010', '1000101110111010'}; ... % /, +, %, *

strCode39 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*';

idx = strfind(strCode39,upper(in)); % Force to upper case
if any(idx)
    result = codesArray{idx};
else
    error('Invalid input - character not part of the Code 39 set');
end

end













