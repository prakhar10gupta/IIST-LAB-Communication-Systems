function [powerSpec, f] = powerSpectrum(tdSignal, fs)
N = length(tdSignal); % length of baseband signal
Xf = fftshift(fft(tdSignal, N));
f = fs/N *(-(N-1)/2: 1: (N-1)/2); % frequency axis for DFT
powerSpec = abs(Xf).^2 / N;
end