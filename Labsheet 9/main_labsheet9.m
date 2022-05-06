%% General modulation and demodulation schemes
close all; clear; clc;
symb_time = 1; % symbol time in seconds, common for all modulation schemes
fc = 20; % carrier frequency
fs = 100*fc; ts = 1/fs; % sampling frequency
% high value for better visualization

%% QPSK 
numofbits = 200;
bits = randi([0 1], 1, numofbits);
% fprintf("Bits generated: %s\n", num2str(bits));

% Pass-band signal generation
[passband_xn, t] = qpsk_modulator(bits, fc, symb_time, ts);
figure; plot(t, passband_xn); xlim([0, 10]);
title('QPSK modulated passband signal'); ylabel('Amplitude'); xlabel('time (s)');

% PSD
avg_power_spec = zeros(1, length(passband_xn));
iterations = 10;
for ii = 1:iterations
    bits = randi([0 1], 1, numofbits);
    passband_xn = qpsk_modulator(bits, fc, symb_time, ts);
    [power_spec, f] = powerSpectrum(passband_xn, fs);
    avg_power_spec = avg_power_spec + power_spec;
end
avg_power_spec = avg_power_spec/iterations;
figure; plotme(f, avg_power_spec, 'c',...
    "Power spectrum of QPSK modulated passband signal", "Frequency (Hz)", "Magnitude");
% Null to null bandwith obtained by observing the plot (=2 Hz)
fprintf('Bit rate for QPSK signal = 2 bits/sec\n');
fprintf('Null to null bandwith obtained by observing the PSD of QPSK signal = 2 Hz\n');

% Signal constellation
figure; plot_constellation(passband_xn, symb_time/ts, fs, fc); grid on;
title("Signal constellation for QPSK modulated passband signal");
xlabel("$\sqrt{\frac{2}{T_s}}\cos (2\pi f_ct)$", 'interpreter', 'latex'); 
ylabel("$-\sqrt{\frac{2}{T_s}}\sin (2\pi f_ct)$", 'interpreter', 'latex');

%% 16-QAM 
numofbits = 400;
bits = randi([0 1], 1, numofbits);
% fprintf("Bits generated: %s\n", num2str(bits));

% Pass-band signal generation
[passband_xn, t] = qam16_modulator(bits, fc, symb_time, ts);
figure; plot(t, passband_xn); xlim([0, 10]);
title('16-QAM modulated passband signal'); ylabel('Amplitude'); xlabel('time (s)');

% PSD
avg_power_spec = zeros(1, length(passband_xn));
iterations = 10;
for ii = 1:iterations
    bits = randi([0 1], 1, numofbits);
    passband_xn = qam16_modulator(bits, fc, symb_time, ts);
    [power_spec, f] = powerSpectrum(passband_xn, fs);
    avg_power_spec = avg_power_spec + power_spec;
end
avg_power_spec = avg_power_spec/iterations;
figure; plotme(f, avg_power_spec, 'c',...
    "Power spectrum of 16-QAM modulated passband signal", "Frequency (Hz)", "Magnitude");
% Null to null bandwith obtained by observing the plot (=2 Hz)
fprintf('\nBit rate for 16-QAM signal = 4 bits/sec\n');
fprintf('Null to null bandwith obtained by observing the PSD of 16-QAM signal = 2 Hz\n');

% Signal constellation
figure; plot_constellation(passband_xn, symb_time/ts, fs, fc); grid on;
title("Signal constellation for 16-QAM modulated passband signal");
xlabel("$\sqrt{\frac{2}{T_s}}\cos (2\pi f_ct)$", 'interpreter', 'latex'); 
ylabel("$-\sqrt{\frac{2}{T_s}}\sin (2\pi f_ct)$", 'interpreter', 'latex');

%% 8-PSK
numofbits = 300;
bits = randi([0 1], 1, numofbits);
% fprintf("Bits generated: %s\n", num2str(bits));

% Pass-band signal generation
[passband_xn, t] = psk8_modulator(bits, fc, symb_time, ts);
figure; plot(t, passband_xn); xlim([0, 10]);
title('8-PSK modulated passband signal'); ylabel('Amplitude'); xlabel('time (s)');

% PSD
avg_power_spec = zeros(1, length(passband_xn));
iterations = 10;
for ii = 1:iterations
    bits = randi([0 1], 1, numofbits);
    passband_xn = psk8_modulator(bits, fc, symb_time, ts);
    [power_spec, f] = powerSpectrum(passband_xn, fs);
    avg_power_spec = avg_power_spec + power_spec;
end
avg_power_spec = avg_power_spec/iterations;
figure; plotme(f, avg_power_spec, 'c',...
    "Power spectrum of 8-PSK modulated passband signal", "Frequency (Hz)", "Magnitude");
% Null to null bandwith obtained by observing the plot (=2 Hz)
fprintf('\nBit rate for 8-PSK signal = 3 bits/sec\n');
fprintf('Null to null bandwith obtained by observing the PSD of 8-PSK signal = 2 Hz\n');

% Signal constellation
figure; plot_constellation(passband_xn, symb_time/ts, fs, fc); grid on;
% ylim([-1.5 1.5]);
title("Signal constellation for 8-PSK modulated passband signal");
xlabel("$\sqrt{\frac{2}{T_s}}\cos (2\pi f_ct)$", 'interpreter', 'latex'); 
ylabel("$-\sqrt{\frac{2}{T_s}}\sin (2\pi f_ct)$", 'interpreter', 'latex');

%% 4-FSK
numofbits = 200;
bits = randi([0 1], 1, numofbits);
% fprintf("Bits generated: %s\n", num2str(bits));

% Pass-band signal generation
fc_vector = [fc-15, fc-5, fc+5, fc+15];
[passband_xn, t] = fsk4_modulator(bits, fc_vector, symb_time, ts);
figure; plot(t, passband_xn); xlim([0, 10]);
title('4-FSK modulated passband signal'); ylabel('Amplitude'); xlabel('time (s)');

% PSD
avg_power_spec = zeros(1, length(passband_xn));
iterations = 10;
for ii = 1:iterations
    bits = randi([0 1], 1, numofbits);
    passband_xn = fsk4_modulator(bits, fc_vector, symb_time, ts);
    [power_spec, f] = powerSpectrum(passband_xn, fs);
    avg_power_spec = avg_power_spec + power_spec;
end
avg_power_spec = avg_power_spec/iterations;
figure; plotme(f, avg_power_spec, 'c',...
    "Power spectrum of 4-FSK modulated passband signal", "Frequency (Hz)", "Magnitude");
% Null to null bandwith obtained by observing the plot (=2 Hz)
fprintf('\nBit rate for 4-FSK signal = 3 bits/sec\n');
fprintf('Null to null bandwith obtained by observing the PSD of 4-FSK signal = 2 Hz\n');

% Signal constellation of FSK - skipping for now
% figure; plot_constellation_FSK(passband_xn, symb_time/ts, fs, fc_vector); grid on;
% title("Signal constellation for 4-FSK modulated passband signal");
% xlabel("$\sqrt{\frac{2}{T_s}}\cos (2\pi f_ct)$", 'interpreter', 'latex'); 
% ylabel("$-\sqrt{\frac{2}{T_s}}\sin (2\pi f_ct)$", 'interpreter', 'latex');

%% Correlation receiver and Decision makers
numofbits = 40;
bits = randi([0 1], 1, numofbits);
% fprintf("Bits generated: %s\n", num2str(bits));

% QPSK
[qpsk_xn, t] = qpsk_modulator(bits, fc, symb_time, ts);
[i, q] = corr_filter(qpsk_xn, fc, symb_time, ts);
bits_qpsk = decisionMaker_qpsk(i, q);
fprintf("\nNumber of error bits received through QPSK = %d\n", sum(bits_qpsk ~= bits));

% 16-QAM
qam16_xn = qam16_modulator(bits, fc, symb_time, ts);
[i, q] = corr_filter(qam16_xn, fc, symb_time, ts);
bits_qam16 = decisionMaker_qam16(i, q);
fprintf("Number of error bits received through 16-QAM = %d\n", sum(bits_qam16 ~= bits));

% 8-PSK
psk8_xn = psk8_modulator(bits, fc, symb_time, ts);
[i, q] = corr_filter(psk8_xn, fc, symb_time, ts);
bits_psk8 = decisionMaker_psk8(i, q);
bits_psk8 = bits_psk8(1:end-2); % to get rid of the last 2 irrelevant bits
fprintf("Number of error bits received through 8-PSK = %d\n", sum(bits_psk8 ~= bits));

% 4-FSK
fc_vector = [fc-15, fc-5, fc+5, fc+15];
fsk4_xn = fsk4_modulator(bits, fc_vector, symb_time, ts);
[i, j, k, l] = corr_filter_fsk(fsk4_xn, fc_vector, symb_time, ts);
bits_fsk4 = decisionMaker_fsk4(i, j, k, l);
fprintf("Number of error bits received through 4-FSK = %d\n", sum(bits_fsk4 ~= bits));