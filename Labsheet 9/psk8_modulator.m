function [passband_xn, t] = psk8_modulator(bits, fc, symb_time, ts)
extra = rem(length(bits), 3); % handling exceptions
if extra ~= 0
    bits = [bits, zeros(1, 3 - extra)]; 
end
symbols = reshape(bits, 3, [])'; % symbol formed by grouping 3 bits
samples_per_symbol = symb_time/ts;
rect_pulse = ones(1, samples_per_symbol);

% Generate 8-PSK baseband signals
[impulses_cos, impulses_sin] = bitsTo8PSKimpulseTrain(symbols, samples_per_symbol);
[baseband_xn_cos, t] = impulseTrainToBaseband(impulses_cos, rect_pulse, ts);
baseband_xn_sin = impulseTrainToBaseband(impulses_sin, rect_pulse, ts);

% orthonormal basis signal vectors
ortho_cos = sqrt(2/symb_time)* cos(2*pi*fc*t);
ortho_sin = -sqrt(2/symb_time)* sin(2*pi*fc*t);

passband_xn = baseband_xn_sin.*ortho_sin + baseband_xn_cos.*ortho_cos;
end