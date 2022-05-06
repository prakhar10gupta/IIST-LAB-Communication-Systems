function [i, q] = corr_filter(signal, fc, symb_time, ts)
% returns i and q values for PSK, QAM schemes
t = 0: ts: symb_time - ts;
samples_per_symbol = symb_time/ts;
num_symbols = floor(length(signal)/samples_per_symbol);
signal = signal(1: num_symbols*samples_per_symbol); % getting rid of trailing zeroes
signal = reshape(signal, samples_per_symbol, num_symbols)';

basis_cos = sqrt(2/symb_time)* cos(2*pi*fc*t);
basis_sin = -sqrt(2/symb_time)* sin(2*pi*fc*t);

i = sum(signal.* basis_cos, 2)'*ts;
q = sum(signal.* basis_sin, 2)'*ts;
end