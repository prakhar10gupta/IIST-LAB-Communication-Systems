function [abs_psd, f, n2nbw] = my_psd(sgnl, fs)
%% generate PSD
auto_corr = xcorr(sgnl); % takes the auto-correlation
abs_psd = abs(fft(auto_corr)); % Fourier transform of auto-correlation gives PSD
N = length(abs_psd);
abs_psd = abs_psd*fs/N; % divide by n*ts = T
f = 0: fs/N : fs - fs/N;
    
%% find null to null bandwidth
[~, indmax] = max(abs_psd);
bin = 1;
threshold = 0.0001;
while(abs_psd(indmax + bin) > threshold)
    bin = bin + 1;
end
n2nbw = 2* bin* fs/N;
end