function [abs_power, f] = powerSpectrum(xn, fs)
Xf = fft(xn);
Xf = fftshift(Xf); % Comment this to get one-sided
N = length(xn);
abs_power = abs(Xf).^2*fs/N;
% abs_power = abs_power(1: floor(end/2)); % Uncomment to get one-sided
f = -(length(abs_power)/2)*fs/N: fs/N : (length(abs_power)/2-1)*fs/N;
end