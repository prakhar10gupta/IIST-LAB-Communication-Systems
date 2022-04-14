%% Early Late gating - 1
close all; clear; clc;
% Pulse transmission parameters
tb = 0.1;
fs = 1000; ts = 1/fs;
samples_per_bit = tb/ts;
pulseAmplitude = 1;
pulseShape = rectPulse(pulseAmplitude, tb, ts);
% pulseShape = sincPulse(2*tb, tb, fs);
% pulseShape = raisedCosinePulse(2*tb, tb, fs, 0.35);

txPulse = pulseShape; % rectangular pulse
% t = ts*(0: length(txPulse)-1);
% figure; stem(t, txPulse)

% Adding delay
delaySamples = zeros(1, randi(1*samples_per_bit));
recvSignal = [delaySamples, txPulse];
t = ts*(0: length(recvSignal)-1);
figure; stem(t, recvSignal);
title('Received Pulse waveform'); xlabel('time (s)'); ylabel('Amplitude');

% Match filtering
matchFilteredSignal = matchFilter(recvSignal, pulseShape);
t = ts*(0: length(matchFilteredSignal)-1);
figure; plot(t, matchFilteredSignal);
title('Match filtered waveform'); xlabel('time (s)'); ylabel('Amplitude');

%%
% Sampling
clockEdge = 1;
samplingOffset = floor(samples_per_bit/2);
delta = floor(samples_per_bit/2);
alpha = 50 * 1/max(matchFilteredSignal); 
[sample, offset, samplingIndex] = earlyLateSampler1(matchFilteredSignal, alpha, delta, clockEdge, samples_per_bit, ts);
fprintf("Sample value = %f\nSampling time = %fs\n", sample, (samplingIndex-1)*ts);

figure; plot(t, matchFilteredSignal);
title('Sample of Match filtered signal using early-late method'); xlabel('time (s)'); ylabel('Amplitude');
hold on;
stem((samplingIndex-1)*ts, sample, '*m');