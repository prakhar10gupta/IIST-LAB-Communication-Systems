close all; clear; clc;

%% Generating Bits 
N = 100;
rng('default')
s = rng
bits = randomBits(N);

%% Defining line code parameters
tb = 0.1; % bit duration
samples_per_pulse = 10;
fs = samples_per_pulse / tb; % sampling frequency
ts = 1/fs;

%% Bits to Baseband
[bbSignal, t] = linecoder(bits, tb, fs);
figure
p = plotme(t, bbSignal, 'c', 'Baseband signal (transmit)', 'time (s)', 'Amplitude');
p.Color = 'b';
ylim([-1.5, 1.5]);
hold on; plot(t, zeros(1, length(t)), '--');

%% Power spectrum
[power, f] = powerSpectrum(bbSignal, fs);
figure
p = plotme(f, power, 'c', 'Power spectrum of baseband signal', 'Frequency (Hz)', 'Power');
p.Color = 'r';
grid on

%% Channel model
channel = channelModel(fs);
[Hf, w] = freqz(channel, 1);
figure
plotme(w/(2*pi)*fs, 10*log10(abs(Hf)), 'c', 'Magnitude response of channel',...
    'Frequency (Hz)', 'Magnitude (dB)');
grid on

%% Channel output
channelOutput = conv(bbSignal, channel);
t_new = [t, t(end) + ts: ts: ts* length(channelOutput) - ts];
figure
p = plotme(t_new, channelOutput, 'c', 'Channel Output', 'time (s)', 'Amplitude');
p.Color = 'b';
hold on; plot(t_new, zeros(1, length(t_new)), '--');

%% Receive filter
receiveFilter = receiveFilter(fs);
[Rf, w] = freqz(receiveFilter, 1);
figure
plotme(w/(2*pi)*fs, 10*log10(abs(Rf)), 'c', 'Magnitude response of Receive Filter',...
    'Frequency (Hz)', 'Magnitude (dB)');
grid on

%% Receive filter output
receivedSignal = conv(channelOutput, receiveFilter);
tFinal = [t_new, t_new(end) + ts: ts: ts* length(receivedSignal) - ts];
figure
plot(t, bbSignal, '--r'); hold on;
p = plotme(tFinal, receivedSignal, 'c', 'Received signal', 'time (s)', 'Amplitude');
p.Color = 'b';
hold on; plot(tFinal, zeros(1, length(tFinal)), '--k');
legend('Received signal', 'Transmitted signal');

%% Sampling the received signal
[samples, tSamples] = sampler(receivedSignal, tFinal, tb, ts, N);
figure
plot(tSamples, samples, 'r*', 'MarkerSize', 7); hold on;
plot(tFinal, receivedSignal, 'b--'); 
title('Samples taken from received signal');
xlabel('time (s)'); ylabel('Amplitude');
legend('Samples', 'Received signal');
hold off

%% Decision maker - samples to bits
bitsReceived = sample2bits(samples);
bitErrors = length(find((bitsReceived ~= bits)));
disp('Number of error bits');
disp(bitErrors);