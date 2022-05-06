function bits = symbol_to_bits_fsk4(symbol)
bits_ref = [0 0; 0 1; 1 0; 1 1];
bits = bits_ref(symbol > 0, :);
end