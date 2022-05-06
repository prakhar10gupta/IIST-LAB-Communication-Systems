function bits = symbol_to_bits_qam16(symbol)
bits = [];
for ii = 1:size(symbol, 1)
    for jj = 1:size(symbol, 2)
        switch(symbol(ii, jj))
            case -3
                add = [0 0];
            case -1
                add = [0 1];
            case 1
                add = [1 0];
            case 3
                add = [1 1];
        end
    bits = [bits, add];    
    end
end
end