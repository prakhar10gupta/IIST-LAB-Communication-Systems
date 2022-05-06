function [passband_xn, t] = qpsk_modulator(bits, fc, symb_time, ts)
extra = rem(length(bits), 2); % handling exceptions
if extra ~= 0
    bits = [bits, zeros(1, 2 - extra)]; 
end
samples_per_symbol = symb_time/ts;
rect_pulse = ones(1, samples_per_symbol);

% Generate BPSK baseband signal
% odd bits here
bits_odd = bits(1: 2: end); 
impulses = bitsToImpulseTrain(bits_odd, samples_per_symbol);
[baseband_xn_odd, t] = impulseTrainToBaseband(impulses, rect_pulse, ts);

% same for even bits
bits_even = bits(2: 2: end);
impulses = bitsToImpulseTrain(bits_even, samples_per_symbol);
baseband_xn_even = impulseTrainToBaseband(impulses, rect_pulse, ts);

% orthonormal basis signal vectors
ortho_odd = sqrt(2/symb_time)* cos(2*pi*fc*t);
ortho_even = -sqrt(2/symb_time)* sin(2*pi*fc*t);

passband_xn = baseband_xn_even.*ortho_even + baseband_xn_odd.*ortho_odd;
end