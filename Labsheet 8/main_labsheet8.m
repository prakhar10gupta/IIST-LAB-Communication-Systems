%% Parameters
close all; clear; clc;
load HELLO_dataset.mat % yeilds 'data' variable
% load SDR_experimental_data.mat
% recv_signal_mag = abs(SSC);

tb = 1/1e3;
fc = 433.9e6;
fs = 2.048e6; ts = 1/fs;
barker13 = [+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
barker13(barker13 == -1) = 0;

%% Down-sampling
downsample_factor = 100;
ts = ts*downsample_factor; fs = fs/downsample_factor; 
samples_per_bit = floor(tb/ts);% samples_per_bit/downsample_factor;
data_ds = downsample(data, downsample_factor);
i_data = data_ds(:, 1); q_data = data_ds(:, 2);
recv_signal_mag = sqrt(i_data.^2 + q_data.^2);

%% Match filtering 
A = 1; pulseShape = rectPulse(A, tb, ts);
filt_signal_mag = matchFilter(recv_signal_mag, pulseShape);
tSignal = (0: length(filt_signal_mag)-1)*ts;
figure; 
subplot(2, 1, 1); plotme((0: length(recv_signal_mag)-1)*ts, recv_signal_mag, 'c',...
    'Received Signal (downsampled by factor of 100)', 'time (s)', 'Amplitude');
subplot(2, 1, 2); plotme(tSignal, filt_signal_mag, 'c',...
    'Received Signal after Match filtering', 'time (s)', 'Amplitude');

%% Bit sync using Early late gating
clock = 1: samples_per_bit: length(filt_signal_mag) - samples_per_bit;
delta = 1;
step_size = samples_per_bit/max(filt_signal_mag); 
threshold = mean(filt_signal_mag);
% [recvSamples, ~, sampleTimeIndices] = earlyLateSampler2(filt_signal_mag, clock, step_size, delta, ts);
[recvSamples, sampleTimeIndices] = early_late_sampler(filt_signal_mag, fs, tb, clock(1), delta, step_size, threshold);
t = ts*(0: length(filt_signal_mag)-1);
figure; plotme(t, filt_signal_mag, 'c',...
    "Match filtered signal samples taken by early-late sampler"...
, "time (s)", "Amplitude"); 
hold on;
sampleTimes = (sampleTimeIndices-1)*ts;
stem(sampleTimes, recvSamples, '*m');

%% Frame sync 
% Conversion to bits followed by Frame detection 
% threshold = mean(filt_signal_mag);
recvBits = decisionMaker(recvSamples, threshold);
figure; plot(recvBits); title('Bits received');

[frameIndices, corrResult] = detectFrames(recvBits, barker13);
figure; plotme(tb*(0:length(corrResult)-1), corrResult, 'c',...
    'Correlation of received (filtered) signal with Barker Sequence', 'Delay (s)', 'Amplitude');

frameDetectionInstants = (frameIndices-1)*tb;
for ii = 1: length(frameDetectionInstants)
    fprintf("Frame #%d detected at %fs\n", ii, frameDetectionInstants(ii));
end

%% Bits to characters
header_size = 13;
data_size = 40;
data_bits = zeros(length(frameIndices), data_size);
for ii = 1:size(data_bits, 1)
    data_bits(ii, :) = recvBits(frameIndices(ii) + header_size : frameIndices(ii)+ header_size + data_size-1);
    bits_array = reshape(data_bits(ii, :), 8, [])';
    decimal_array = bi2de(bits_array, 'left-msb');
    characters = char(decimal_array');
    fprintf('Frame %d: %s\n', ii, characters);
end