function [i, j, k, l] = corr_filter_fsk(signal, fc_vector, symb_time, ts)
% returns i and q values for PSK, QAM schemes
t = 0: ts: symb_time - ts;
samples_per_symbol = symb_time/ts;
num_symbols = floor(length(signal)/samples_per_symbol);
signal = signal(1: num_symbols*samples_per_symbol); % getting rid of trailing zeroes
signal = reshape(signal, samples_per_symbol, num_symbols)';

basis_vectors = sqrt(2/symb_time)*[cos(2*pi*fc_vector(1)*t); cos(2*pi*fc_vector(2)*t); ...
    cos(2*pi*fc_vector(3)*t); cos(2*pi*fc_vector(4)*t)];

i = sum(signal.* basis_vectors(1, :), 2)'*ts;
j = sum(signal.* basis_vectors(2, :), 2)'*ts;
k = sum(signal.* basis_vectors(3, :), 2)'*ts;
l = sum(signal.* basis_vectors(4, :), 2)'*ts;
end