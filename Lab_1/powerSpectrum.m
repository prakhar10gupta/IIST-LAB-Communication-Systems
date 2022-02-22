function [powerSpec, f] = powerSpectrum(tdSignal, fs)
N = length(tdSignal); % length of baseband signal
Xf = fft(tdSignal, N);
f = fs/N *(0: 1: N-1); % frequency axis for DFT
powerSpec = abs(Xf).^2 / N;
end