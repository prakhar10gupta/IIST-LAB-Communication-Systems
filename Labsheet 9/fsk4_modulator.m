function [passband_xn, t] = fsk4_modulator(bits, fc_vector, symb_time, ts)
% assuming 5 Hz separation between each, verified by observing PSD of QPSK
samples_per_symbol = symb_time/ts;
rect_pulse = ones(1, samples_per_symbol);
symbols = reshape(bits, 2, [])'; % symbol formed by grouping 2 bits

% Generate 4-FSK baseband signals
impulses = [bitsToFSKimpulseTrain(symbols, samples_per_symbol, [0,0]); ...
    bitsToFSKimpulseTrain(symbols, samples_per_symbol, [0,1]); ...
    bitsToFSKimpulseTrain(symbols, samples_per_symbol, [1,0]); ...
    bitsToFSKimpulseTrain(symbols, samples_per_symbol, [1,1])];
[baseband_xn1, t] = impulseTrainToBaseband(impulses(1, :), rect_pulse, ts);
baseband_xn2 = impulseTrainToBaseband(impulses(2, :), rect_pulse, ts);
baseband_xn3 = impulseTrainToBaseband(impulses(3, :), rect_pulse, ts); 
baseband_xn4 = impulseTrainToBaseband(impulses(4, :), rect_pulse, ts);
baseband_xns = [baseband_xn1; baseband_xn2; baseband_xn3; baseband_xn4];

% orthonormal basis signal vectors
ortho_xns = sqrt(2/symb_time)* [cos(2*pi*fc_vector(1)*t); cos(2*pi*fc_vector(2)*t); ...
    cos(2*pi*fc_vector(3)*t); cos(2*pi*fc_vector(4)*t)];

passband_xn = ortho_xns.*baseband_xns;
passband_xn = sum(passband_xn);
end