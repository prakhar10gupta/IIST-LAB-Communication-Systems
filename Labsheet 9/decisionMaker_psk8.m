function bits = decisionMaker_psk8(i, q)
% returns 8-PSK symbols using minimum distance rule
constell_vectors = exp(1i*2*pi*(0:7)/8);
symb_constell = [real(constell_vectors); imag(constell_vectors)]';

symb_recv = [i; q]'; 
bits = [];
for ii = 1: length(symb_recv)
    sq_distance_from_each_symbol = sum( (symb_constell - symb_recv(ii, :)).^2, 2 );
    estimated_symbol = symb_constell(sq_distance_from_each_symbol == min(sq_distance_from_each_symbol), :);
    bits = [bits, symbol_to_bits_psk8(estimated_symbol)];
end
end