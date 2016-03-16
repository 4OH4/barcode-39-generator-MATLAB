function output = encodeStringCode39(input)
% Encode string input into a binary sequence using Code 39 barcode format

assert(ischar(input));

% Start character
bitString = encodeCharacter('*'); 

% Send each character from the input to be encoded
for i = 1:length(input)
    bitString = [bitString,encodeCharacter(input(i))];
end

% Stop character
bitString = [bitString,encodeCharacter('*')]; 

% Convert string to logical vector
output = logical(bitString(:)'-'0');    % Thanks Mischa Kim
end