function bits = decisionMaker_qpsk(i, q)
% returns QPSK symbols using minimum distance rule
i_constell = [-1, 1]; q_constell = i_constell;
symb_constell = generate_constellation_symbols(i_constell, q_constell);

symb_recv = [i; q]'; 
bits = [];
for ii = 1: length(symb_recv)
    sq_distance_from_each_symbol = sum( (symb_constell - symb_recv(ii, :)).^2, 2 );
    estimated_symbol = symb_constell(sq_distance_from_each_symbol == min(sq_distance_from_each_symbol), :);
    bits = [bits, symbol_to_bits_qpsk(estimated_symbol)];
end
end