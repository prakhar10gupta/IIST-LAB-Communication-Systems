%% SER and BER for general modulation and demodulation schemes
close all; clear; clc;
symb_time = 1; % symbol time in seconds, common for all modulation schemes
fc = 20; % carrier frequency
fs = 100*fc; ts = 1/fs; % sampling frequency
fs_symb = symb_time*fs;
num_symb = 5000;

%% Passband signal generation 
% QPSK
num_bits_qpsk = num_symb*2;
bits_qpsk = randi([0 1], 1, num_bits_qpsk);
symb_qpsk = reshape(bits_qpsk, 2, [])';
qpsk_xn = qpsk_modulator(bits_qpsk, fc, symb_time, ts);

% 16-QAM
num_bits_qam16 = num_symb*4;
bits_qam16 = randi([0 1], 1, num_bits_qam16);
symb_qam16 = reshape(bits_qam16, 4, [])';
qam16_xn = qam16_modulator(bits_qam16, fc, symb_time, ts);

% 8-PSK
num_bits_psk8 = num_symb*3;
bits_psk8 = randi([0 1], 1, num_bits_psk8);
symb_psk8 = reshape(bits_psk8, 3, [])';
psk8_xn = psk8_modulator(bits_psk8, fc, symb_time, ts);

% 4-FSK
num_bits_fsk4 = num_symb*2;
bits_fsk4 = randi([0 1], 1, num_bits_fsk4);
symb_fsk4 = reshape(bits_fsk4, 2, [])';
fc_vector = [fc-15, fc-5, fc+5, fc+15];
fsk4_xn = fsk4_modulator(bits_fsk4, fc_vector, symb_time, ts);

%% Noisy channel output
% close all;
atten_factor = 1; % no attenutation assumed
noise_var = 0.5; % 0.5, 2, 15
time_window = symb_time*5;
chann_out_qpsk = noisy_channel(qpsk_xn, atten_factor, noise_var);
figure; plotme(0: ts: ts*(length(qpsk_xn)-1), chann_out_qpsk, 'c',...
    'Channel output of QPSK signal', 'time (s)', 'Amplitude'); xlim([0, time_window]);

chann_out_qam16 = noisy_channel(qam16_xn, atten_factor, noise_var);
figure; plotme(0: ts: ts*(length(qam16_xn)-1), chann_out_qam16, 'c',...
    'Channel output of 16-QAM signal', 'time (s)', 'Amplitude'); xlim([0, time_window]);

chann_out_psk8 = noisy_channel(psk8_xn, atten_factor, noise_var);
figure; plotme(0: ts: ts*(length(psk8_xn)-1), chann_out_psk8, 'c',...
    'Channel output of 8-PSK signal', 'time (s)', 'Amplitude'); xlim([0, time_window]);

chann_out_fsk4 = noisy_channel(fsk4_xn, atten_factor, noise_var);
figure; plotme(0: ts: ts*(length(fsk4_xn)-1), chann_out_fsk4, 'c',...
    'Channel output of 4-FSK signal', 'time (s)', 'Amplitude'); xlim([0, time_window]);

%% Signal constellations for different noise variances
atten_factor = 1; % no attenutation assumed
noise_var = [0.5, 2, 15];
for ii = noise_var
    chann_out_qpsk = noisy_channel(qpsk_xn, atten_factor, ii);
    chann_out_qam16 = noisy_channel(qam16_xn, atten_factor, ii);
    chann_out_psk8 = noisy_channel(psk8_xn, atten_factor, ii);
    chann_out_fsk4 = noisy_channel(fsk4_xn, atten_factor, ii);
    
    figure; grid on
    tiledlayout('flow');
    nexttile;
    plot_constellation(chann_out_qpsk, fs_symb, fs, fc); title('QPSK');
    nexttile;
    plot_constellation(chann_out_qam16, fs_symb, fs, fc); title('16-QAM');
    nexttile;
    plot_constellation(chann_out_psk8, fs_symb, fs, fc); title('8-PSK');
    sgtitle(['Signal constellations for \sigma^2 = ', num2str(ii)]);
end

%% BER and SER plots
atten_factor = 1; % no attenutation assumed
noise_var = 0:100:1000;
ber = zeros(length(noise_var), 4);
ser = ber;

for ii = 1: length(noise_var)
    % QPSK
    chann_out_qpsk = noisy_channel(qpsk_xn, atten_factor, noise_var(ii));
    [i, q] = corr_filter(chann_out_qpsk, fc, symb_time, ts);
    bits = decisionMaker_qpsk(i, q);
    ber(ii, 1) = sum(bits ~= bits_qpsk)/num_bits_qpsk;
    symb = reshape(bits, 2, [])';
    ser(ii, 1) = sum(sum(symb ~= symb_qpsk, 2) > 0)/num_symb;
    
    % 16-QAM
    chann_out_qam16 = noisy_channel(qam16_xn, atten_factor, noise_var(ii));
    [i, q] = corr_filter(chann_out_qam16, fc, symb_time, ts);
    bits = decisionMaker_qam16(i, q);
    ber(ii, 2) = sum(bits ~= bits_qam16)/num_bits_qam16;
    symb = reshape(bits, 4, [])';
    ser(ii, 2) = sum(sum(symb ~= symb_qam16, 2) > 0)/num_symb;
    
    chann_out_psk8 = noisy_channel(psk8_xn, atten_factor, noise_var(ii));
    [i, q] = corr_filter(chann_out_psk8, fc, symb_time, ts);
    bits = decisionMaker_psk8(i, q);
    ber(ii, 3) = sum(bits ~= bits_psk8)/num_bits_psk8;
    symb = reshape(bits, 3, [])';
    ser(ii, 3) = sum(sum(symb ~= symb_psk8, 2) > 0)/num_symb;
    
    chann_out_fsk4 = noisy_channel(fsk4_xn, atten_factor, noise_var(ii));
    [i, j, k, l] = corr_filter_fsk(chann_out_fsk4, fc_vector, symb_time, ts);
    bits = decisionMaker_fsk4(i, j, k, l);
    ber(ii, 4) = sum(bits ~= bits_fsk4)/num_bits_fsk4;
    symb = reshape(bits, 2, [])';
    ser(ii, 4) = sum(sum(symb ~= symb_fsk4, 2) > 0)/num_symb;
end

figure; hold on
plot(noise_var, ber(:, 1));
plot(noise_var, ber(:, 2)); 
plot(noise_var, ber(:, 3)); 
plot(noise_var, ber(:, 4)); hold off
title('Bit error rate (BER) for different modulation schemes');
xlabel('\sigma^2'); ylabel('BER');
legend('QPSK', '16-QAM', '8-PSK', '4-FSK');

figure; hold on
plot(noise_var, ser(:, 1));
plot(noise_var, ser(:, 2)); 
plot(noise_var, ser(:, 3)); 
plot(noise_var, ser(:, 4)); hold off
title('Symbol error rate (SER) for different modulation schemes');
xlabel('\sigma^2'); ylabel('SER');
legend('QPSK', '16-QAM', '8-PSK', '4-FSK');