function [passband_xn, t] = qam16_modulator(bits, fc, symb_time, ts)
extra = rem(length(bits), 4); % handling exceptions
if extra ~= 0
    bits = [bits, zeros(1, 4 - extra)]; % handling exceptions
end
samples_per_symbol = symb_time/ts;
rect_pulse = ones(1, samples_per_symbol);

% Partitioning bit stream to pairs
bitpairs = reshape(bits, 2, [])';
bitpairs_cos = bitpairs(1: 2: end, :);
bitpairs_sin = bitpairs(2: 2: end, :);

% Generate 4-PAM baseband signals
impulses_cos = bitsTo4PAMimpulseTrain(bitpairs_cos, samples_per_symbol);
[baseband_xn_cos, t] = impulseTrainToBaseband(impulses_cos, rect_pulse, ts);

impulses_sin = bitsTo4PAMimpulseTrain(bitpairs_sin, samples_per_symbol);
baseband_xn_sin = impulseTrainToBaseband(impulses_sin, rect_pulse, ts);

% orthonormal basis signal vectors
ortho_cos = sqrt(2/symb_time)* cos(2*pi*fc*t);
ortho_sin = -sqrt(2/symb_time)* sin(2*pi*fc*t);

passband_xn = baseband_xn_sin.*ortho_sin + baseband_xn_cos.*ortho_cos;
end