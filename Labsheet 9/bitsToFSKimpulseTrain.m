function impulseTrain = bitsToFSKimpulseTrain(symbols, upsampleRate, ref_symbol)
num_symbols = size(symbols, 1); % number of symbols = number of rows
impulseTrain = zeros(1, num_symbols*upsampleRate);
comparision = symbols == ref_symbol;
impulseTrain(1: upsampleRate: end) = (comparision(:, 1).*comparision(:, 2))';
end