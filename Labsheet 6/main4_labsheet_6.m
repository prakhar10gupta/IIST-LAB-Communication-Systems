close all; clear; clc;
% Pulse transmission parameters
tb = 0.1;
fs = 1000; ts = 1/fs;
samples_per_bit = tb/ts;
pulseAmplitude = 1;
pulseShape = rectPulse(pulseAmplitude, tb, ts);

%% Bits and frames definition
% Frame parameters
% Uncomment for Part:1
% numofbits = 1000;
% frameDataSize = 50;
% numofFrames = numofbits/frameDataSize;

% Uncomment for Part:2
numofFrames = 1000;
frameDataSize = 50;
numofbits = numofFrames * frameDataSize;

% Header
barker13 = [+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
barker13(barker13 == -1) = 0;
frameHeader = [repmat([1 0], 1, 5), barker13];
headerLength = length(frameHeader);

% Bit sequence generation
% rng('default'); % s = rng; 
bits = randi([0 1], 1, numofbits);

%% Baseband signal generation
impulseTrainForSignal = [];
for iter = 1:numofFrames
    timegapSamples = random_delay_samples(samples_per_bit);
    frameData = bits(1+(iter-1)*frameDataSize : iter*frameDataSize);
    frameBits = [frameHeader, frameData];
    impulseTrainForFrame = bitsToImpulseTrain(frameBits, samples_per_bit);
    impulseTrainForSignal = [impulseTrainForSignal, timegapSamples, impulseTrainForFrame];
end
basebandSignal = impulseTrainToBaseband(impulseTrainForSignal, pulseShape, ts);
tSignal = ts*(0:length(basebandSignal)-1);
figure; plotme(tSignal, basebandSignal, 'c',...
    'Baseband Signal', 'time (s)', 'Amplitude');

%% Channel output and filtering
channelAttenuation = 0.8;
noiseVariance = 0.9;
channelOutput = no_ISI_channel(basebandSignal, channelAttenuation, noiseVariance, samples_per_bit);
tSignal = ts*(0:length(channelOutput)-1);
figure; plotme(tSignal, channelOutput, 'c',...
    'Channel Output', 'time (s)', 'Amplitude');

% Match filtering 
matchFilteredSignal = matchFilter(channelOutput, pulseShape);
tSignal = (0: length(matchFilteredSignal)-1)*ts;
figure; plotme(tSignal, matchFilteredSignal, 'c',...
    'Received Signal after Match filtering', 'time (s)', 'Amplitude');

%% Bit sync using Early late gating
clock = 1: samples_per_bit: length(matchFilteredSignal) - samples_per_bit;
delta = 3;
alpha = 30 * 1/max(matchFilteredSignal); 
[recvSamples, ~, sampleTimeIndices] = earlyLateSampler2(matchFilteredSignal, clock, alpha, delta, ts);
t = ts*(0: length(matchFilteredSignal)-1);
figure; plotme(t, matchFilteredSignal, 'c',...
    "Match filtered signal samples taken by early-late sampler"...
, "time (s)", "Amplitude"); 
hold on;
sampleTimes = (sampleTimeIndices-1)*ts;
stem(sampleTimes, recvSamples, '*m');

%% Frame sync 
% Conversion to bits followed by Frame detection 
threshold = 0;
recvBits = decisionMaker(recvSamples, threshold);
figure; plot(recvBits); title('Bits received');

[frameIndices, corrResult] = detectFrames(recvBits, barker13);
figure; plotme(tb*(0:length(corrResult)-1), corrResult, 'c',...
    'Correlation of received (filtered) signal with Barker Sequence', 'Delay (s)', 'Amplitude');

frameDetectionInstants = (frameIndices-1)*tb;
frameStartErrorRate = 1 - length(frameIndices)/numofFrames;
for ii = 1: length(frameDetectionInstants)
    fprintf("Frame #%d detected at %fs\n", ii, frameDetectionInstants(ii));
end
fprintf("\nFrame-start-error-rate = %f\n", frameStartErrorRate);

%% Frame start error plot
numofFrames = 1000;
frameDataSize = 50;
numofbits = numofFrames * frameDataSize;
bits = randi([0 1], 1, numofbits);
impulseTrainForSignal = [];
for iter = 1:numofFrames
    timegapSamples = random_delay_samples(samples_per_bit);
    frameData = bits(1+(iter-1)*frameDataSize : iter*frameDataSize);
    frameBits = [frameHeader, frameData];
    impulseTrainForFrame = bitsToImpulseTrain(frameBits, samples_per_bit);
    impulseTrainForSignal = [impulseTrainForSignal, timegapSamples, impulseTrainForFrame];
end
basebandSignal = impulseTrainToBaseband(impulseTrainForSignal, pulseShape, ts);

channelAttenuation = 0.8;
noiseVarArray = 0: 10: 200;
frameStartErrorRateArray = zeros(1, length(noiseVarArray));
for ii = 1: length(noiseVarArray)
    noiseVariance = noiseVarArray(ii);
    channelOutput = no_ISI_channel(basebandSignal, channelAttenuation, noiseVariance, samples_per_bit);
    matchFilteredSignal = matchFilter(channelOutput, pulseShape);

    clock = 1: samples_per_bit: length(matchFilteredSignal) - samples_per_bit;
    delta = 3;
    alpha = 30 * 1/max(matchFilteredSignal); 
    [recvSamples, ~, sampleTimeIndices] = earlyLateSampler2(matchFilteredSignal, clock, alpha, delta, ts);

    threshold = 0;
    recvBits = decisionMaker(recvSamples, threshold);
    [frameIndices, corrResult] = detectFrames(recvBits, barker13);
    frameDetectionInstants = (frameIndices-1)*tb;
    frameStartErrorRateArray(ii) = 1 - length(frameIndices)/numofFrames;
end
figure; plotme(noiseVarArray, frameStartErrorRateArray, 'c',...
    'Frame-Start-Error-Rate vs \sigma^2', '\sigma^2', 'Frame-Start-Error-Rate');