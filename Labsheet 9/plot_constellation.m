function plot_constellation(signal, samples_per_symbol_time, samples_per_second, fc)

frequency_offset = 0;
phase_offset = 0;

num_symbols = floor(length(signal)/samples_per_symbol_time);
signal = signal(1:num_symbols * samples_per_symbol_time);
signal = reshape(signal, samples_per_symbol_time, num_symbols)';
Ts = samples_per_symbol_time/samples_per_second; %symbol time
constellation = [];
basis_cos = sqrt(2/Ts)*cos(phase_offset + 2 * pi * (fc + frequency_offset) * [0:samples_per_symbol_time - 1]/samples_per_second);
basis_sin = sqrt(2/Ts)*sin(phase_offset + 2 * pi * (fc + frequency_offset) * [0:samples_per_symbol_time - 1]/samples_per_second);
for i = 1:num_symbols
    signal_cos_component = sum(signal(i, :) .* basis_cos) / samples_per_second;
    signal_sin_component = sum(signal(i, :) .* basis_sin) / samples_per_second;
    constellation = [constellation; [signal_cos_component, signal_sin_component]];
end

scatter(constellation(:,1), constellation(:,2), 'x');
end

