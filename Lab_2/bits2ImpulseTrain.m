function [impulseTrain] = bits2ImpulseTrain(bits, tb, fs)
ts = 1/fs;
nBits = length(bits);
samples = tb/ts;
impulseTrain = zeros(1, nBits*samples);
for k = 1:length(bits)
impulseTrain(1 + (k-1)*samples) = -1 + 2*bits(k);
end
