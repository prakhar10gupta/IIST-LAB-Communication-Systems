function bits = decisionMaker_fsk4(i, j, k, l)
% returns FSK symbols using minimum distance rule
bits_ref = [0 0; 0 1; 1 0; 1 1];
symb_constell = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
symb_recv = [i; j; k; l]'; 
bits = [];
for ii = 1: length(symb_recv)
    sq_distance_from_each_symbol = sum( (symb_constell - symb_recv(ii, :)).^2, 2 );
    estimated_symbol = symb_constell(sq_distance_from_each_symbol == min(sq_distance_from_each_symbol), :);
    bits = [bits, symbol_to_bits_fsk4(estimated_symbol)];
end
end