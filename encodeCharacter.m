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

switch(in)
    case {'A','a'} 
        result = '1101010010110';
    case {'B','b'} 
        result = '1011010010110';
    case {'C','c'} 
        result = '1101101001010';
    case {'D','d'} 
        result = '1010110010110';
    case {'E','e'} 
        result = '1101011001010';
    case {'F','f'} 
        result = '1011011001010';
    case {'G','g'} 
        result = '1010100110110';
    case {'H','h'} 
        result = '1101010011010';
    case {'I','i'} 
        result = '1011010011010';
    case {'J','j'} 
        result = '1010110011010';
    case {'K','k'} 
        result = '1101010100110';
    case {'L','l'} 
        result = '1011010100110';
    case {'M','m'} 
        result = '1101101010010';
    case {'N','n'} 
        result = '1010110100110';
    case {'O','o'} 
        result = '1101011010010';
    case {'P','p'} 
        result = '1011011010010';
    case {'Q','q'} 
        result = '1010101100110';
    case {'R','r'} 
        result = '1101010110010';
    case {'S','s'} 
        result = '1011010110010';
    case {'T','t'} 
        result = '1010110110010';
    case {'U','u'} 
        result = '1100101010110';
    case {'V','v'} 
        result = '1001101010110';
    case {'W','w'} 
        result = '1100110101010';
    case {'X','x'} 
        result = '1001011010110';
    case {'Y','y'} 
        result = '1100101101010';
    case {'Z','z'} 
        result = '1001101101010';
    case '-' 
        result = '1001010110110';
    case '.' 
        result = '1100101011010';
    case ' ' 
        result = '1001101011010';
    case '$' 
        result = '1001001001010';
    case '\' 
        result = '1001001010010';
    case '+' 
        result = '1001010010010';
    case '%' 
        result = '1010010010010';
    case '*' 
        result = '1001011011010';
    case '0' 
        result = '1010011011010';
    case '1' 
        result = '1101001010110';
    case '2' 
        result = '1011001010110';
    case '3' 
        result = '1101100101010';
    case '4' 
        result = '1010011010110';
    case '5' 
        result = '1101001101010';
    case '6' 
        result = '1011001101010';
    case '7' 
        result = '1010010110110';
    case '8' 
        result = '1101001011010';
    case '9' 
        result = '1011001011010';
end













