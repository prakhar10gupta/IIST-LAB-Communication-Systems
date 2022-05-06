function [cos_train, sin_train] = bitsTo8PSKimpulseTrain(symbols, upsampleRate)
num_symbols = size(symbols, 1); % number of symbols = number of rows
k = bi2de(symbols, 'left-msb')'; % converts binary to decimal number
space_vectors = exp(1i*2*pi*k/8); % each symbol mapped to one of the 8 roots of unity

cos_train = zeros(1, num_symbols*upsampleRate);
cos_train(1: upsampleRate: end) = real(space_vectors); 

sin_train = zeros(1, num_symbols*upsampleRate);
sin_train(1: upsampleRate: end) = imag(space_vectors);
end