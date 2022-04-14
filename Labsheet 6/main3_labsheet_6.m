close all; clear; clc;
% Bits generation
N = 100; % any even number
bits = repmat([1, 0], 1, N/2); % alternating 1s and 0s

% Pulse parameters
tb = 0.1;
fs = 1000; ts = 1/fs;
samples_per_bit = tb/ts;
pulseAmplitude = 1;
pulseShape = rectPulse(pulseAmplitude, tb, ts);

% Baseband signal generation
impulseTrain = bitsToImpulseTrain(bits, samples_per_bit);
txSignal = impulseTrainToBaseband(impulseTrain, pulseShape, ts);
t = ts*(0: length(txSignal)-1);
figure; plotme(t, txSignal, 'd', "Transmit signal"...
, "time (s)", "Amplitude");

% Passing through channel
atten = 0.8; noiseVar = 0.1;
channelOut = idealChannel(txSignal, atten, noiseVar);
D = randi(samples_per_bit); 
delaySamples = zeros(1, D);
recvSignal = [delaySamples, channelOut];
t = ts*(0: length(recvSignal)-1);
figure; plotme(t, recvSignal, 'c', "Received signal"...
, "time (s)", "Amplitude");

% Match filtering
matchFilteredSignal = matchFilter(recvSignal, pulseShape);
t = ts*(0: length(matchFilteredSignal)-1);
figure; plotme(t, matchFilteredSignal, 'c', "Match filtered signal"...
, "time (s)", "Amplitude");

eyediagram(matchFilteredSignal, 1*samples_per_bit);

%% Sampling without early-late gating
clock = 1: samples_per_bit: length(matchFilteredSignal) - samples_per_bit;
samplingOffset = floor(samples_per_bit/2); 
% taking offset at half bit time gives good results, resonsable also to take it
samplingIndex = clock + samplingOffset;
sampleEstimates = matchFilteredSignal(clock);
t = ts*(0: length(matchFilteredSignal)-1);
figure; plotme(t, matchFilteredSignal, 'c',...
    "Match filtered signal samples taken without early-late gating"...
, "time (s)", "Amplitude"); 
hold on;
stem((clock-1)*ts, sampleEstimates, '*m');
hold off;
 
%% Sampling using early-late method (Early Late Gating - 2)
delta = 4;
% a value closer to half the total width of pulse should do
% as smaller can cause issue due to many zeros present

alpha = 30 * 1/max(matchFilteredSignal); 
% smaller the values of signal is, smaller would be the difference between
% two samples, hence larger alpha desired in such a case
% similar thought for largere signal.
% max can be obtained by measuring power of recv signal
% but won't work at very low SNR (very high noise variance)

% [newSampleEstimates, newSampleIndexEstimates] = early_late_sampler(matchFilteredSignal, fs, tb, samples_per_bit, 3, 0.4, 0);
[newSampleEstimates, samplingOffset, newSampleIndexEstimates] = earlyLateSampler2(matchFilteredSignal, clock, alpha, delta, ts);
t = ts*(0: length(matchFilteredSignal)-1);
figure; plotme(t, matchFilteredSignal, 'c',...
    "Match filtered signal samples taken by early-late sampler"...
, "time (s)", "Amplitude"); 
hold on;
samplingTimeEstimates = (newSampleIndexEstimates-1)*ts;
stem(samplingTimeEstimates, newSampleEstimates, '*m');
fprintf("Sampling Offset = %f\n", (samplingOffset)*ts);

idealSamplingTimes = (D + clock -1)*ts;
mean_sq_error = mean((idealSamplingTimes - samplingTimeEstimates).^2);
fprintf("Mean square error in sampling instants = %d for attenuation = %f and noise variance = %f\n", mean_sq_error, atten, noiseVar);

%% Calculating mean squared error (MSE) for fixed attenuation and noise variance
% Taking values of delta and alpha from previous section
ultimate_mean_sq_error = 0;
for ii = 1: 1000
    D = randi(samples_per_bit); 
    delaySamples = zeros(1, D);
    recvSignal = [delaySamples, channelOut];
    matchFilteredSignal = matchFilter(recvSignal, pulseShape);
    clock = 1: samples_per_bit: length(matchFilteredSignal) - samples_per_bit;
    delta = 4; alpha = 10 * 1/max(matchFilteredSignal); 
%     [newSampleEstimates, newSampleIndexEstimates] = early_late_sampler(matchFilteredSignal, fs, tb, samples_per_bit, delta, alpha, 0);
    [newSampleEstimates, ~, newSampleIndexEstimates] = earlyLateSampler2(matchFilteredSignal, clock, alpha, delta, ts);
    samplingTimeEstimates = (newSampleIndexEstimates-1)*ts;
    idealSamplingTimes = (D + clock -1)*ts;
    mean_sq_error = mean((idealSamplingTimes - samplingTimeEstimates).^2);
    ultimate_mean_sq_error = ultimate_mean_sq_error + mean_sq_error;
end
ultimate_mean_sq_error = ultimate_mean_sq_error/1000;
fprintf("Mean square error in sampling instants = %d for attenuation = %f and noise variance = %f\n", ultimate_mean_sq_error, atten, noiseVar);

%% MSE vs noise variance
% atten = 0.8; 
% D = randi(samples_per_bit); 
% delaySamples = zeros(1, D);
noiseVarArray = 0: 0.1: 1;
mean_sq_error_array = zeros(1, length(noiseVarArray));
for ii = 1: length(noiseVar)
    channelOut = idealChannel(txSignal, atten, noiseVarArray(ii));
    recvSignal = [delaySamples, channelOut];
    matchFilteredSignal = matchFilter(recvSignal, pulseShape);
    [newSampleEstimates, ~, newSampleIndexEstimates] = earlyLateSampler2(matchFilteredSignal, clock, alpha, delta, ts);
    samplingTimeEstimates = (newSampleIndexEstimates-1)*ts;
    idealSamplingTimes = (D + clock -1)*ts;
    mean_sq_error_array(ii) = mean((idealSamplingTimes - samplingTimeEstimates).^2);
end
figure; plotme(noiseVarArray, mean_sq_error_array/1e-7, 'c',...
    "Mean square error in sampling instants vs \sigma^2", "\sigma^2", "MSE (\times 10^{-7})"); 

%% MSE vs N (number of iterations)
% keeping all other parameters constant
% atten = 0.8; 
% D = randi(samples_per_bit); 
% delaySamples = zeros(1, D);
% noise variance = 0.1;
samplingOffset = floor(samples_per_bit/2); 
N_array = 10: 6: 1000;
mean_sq_error_array2 = zeros(1, length(N_array));
for ii = 1: length(N_array)
    bits = repmat([1, 0], 1, N_array(ii)/2); 
    impulseTrain = bitsToImpulseTrain(bits, samples_per_bit);
    txSignal = impulseTrainToBaseband(impulseTrain, pulseShape, ts);
    
    channelOut = idealChannel(txSignal, atten, noiseVar);
    recvSignal = [delaySamples, channelOut];
    matchFilteredSignal = matchFilter(recvSignal, pulseShape);
    
    clock = samples_per_bit: samples_per_bit: length(matchFilteredSignal) - samples_per_bit;
    samplingIndex = clock + samplingOffset;
    [newSampleEstimates, ~, newSampleIndexEstimates] = earlyLateSampler2(matchFilteredSignal, clock, alpha, delta, ts);
    samplingTimeEstimates = (newSampleIndexEstimates-1)*ts;
    idealSamplingTimes = (D + clock - 1)*ts;
    mean_sq_error_array2(ii) = mean((idealSamplingTimes - samplingTimeEstimates).^2);
end
figure; plotme(N_array, mean_sq_error_array2, 'c',...
    "MSE in sampling instants vs iterations N", "N", "MSE"); 