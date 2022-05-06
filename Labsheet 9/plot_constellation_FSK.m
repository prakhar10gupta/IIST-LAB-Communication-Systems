function plot_constellation_FSK(signal, samples_per_symbol_time, samples_per_second, fc_arr)

frequency_offset = 0;
phase_offset = 0;

num_symbols = floor(length(signal)/samples_per_symbol_time);
signal = signal(1:num_symbols * samples_per_symbol_time);
signal = reshape(signal, samples_per_symbol_time, num_symbols)';

constellation = [];
t = (0:samples_per_symbol_time - 1)/samples_per_second;
basis = cos(phase_offset + 2 * pi * kron((fc_arr + frequency_offset), t));
basis = reshape(basis, length(t), []);
for i = 1:num_symbols
    signal_basis_component = 2*sum(signal(i, :) .* basis) / samples_per_symbol_time;
    constellation = [constellation; signal_basis_component];
end
scatter(constellation(:,1), constellation(:,2), 'x');
    

