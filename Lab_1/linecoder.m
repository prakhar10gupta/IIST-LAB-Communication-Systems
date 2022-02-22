function [bb_signal, t] = linecoder(bits, tb, fs)
N = length(bits);
samples_per_bit = fs * tb;
bb_array = zeros(samples_per_bit, N); 
for i = 1:length(bits)
    if bits(i) == 1
        bb_array(:, i) = 1;
    else
        bb_array(:, i) = -1;
    end
end
bb_signal = reshape(bb_array, [1, N*samples_per_bit]);
ts = 1/fs;
t = 0: ts: N*tb - ts;
end