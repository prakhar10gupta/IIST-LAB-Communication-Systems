function impulseTrain = bitsTo4PAMimpulseTrain(bitpairs, upsampleRate)
npairs = size(bitpairs, 1); % number of pairs = number of rows
impulseTrain = zeros(1, npairs*upsampleRate);
impulseTrain(1: upsampleRate: end) = -3 + 4*bitpairs(:, 1) + 2*bitpairs(:, 2); 
end