close all; clear; clc;
% Pulse and sampling parameters
tb = 0.1;
fs = 100; ts = 1/fs;
samples_per_bit = tb/ts;
pulseAmplitude = 1;
pulseShape = rectPulse(pulseAmplitude, tb, ts);

%% Sending a sequence of bits as frames
% Frame generation
% Barker Info
barker13 = [+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
barker13(barker13 == -1) = 0;frameHeader = barker13;

% Uncomment this for Part:1
numofbits = 1000;
frameDataSize = 50;
numofFrames = numofbits/frameDataSize;

% Uncomment this for Part:2
% numofFrames = 1000;
% frameDataSize = 50;
% numofbits = numofFrames * frameDataSize;

rng('default');
bits = randi([0 1], 1, numofbits);
frames = bitsToFrames(bits, frameHeader);

% Baseband signal generation
impulseTrainForSignal = [];
for iter = 1:numofFrames
    timegapSamples = timegapBetweenFrames(samples_per_bit);
    impulseTrainForFrame = bitsToImpulseTrain(frames(iter, :), samples_per_bit);
    impulseTrainForSignal = [impulseTrainForSignal, timegapSamples, impulseTrainForFrame];
end
basebandSignal = impulseTrainToBaseband(impulseTrainForSignal, pulseShape, ts);
tSignal = ts*(0:length(basebandSignal)-1);
figure; plotme(tSignal, basebandSignal, 'd',...
    'Baseband Signal', 'time (s)', 'Amplitude');

%% Frame synchronization using autocorrelation: Part 1
% Channel output
channelAttenuation = 0.8;
noiseVariance = 0.1;
channelOutput = idealChannel(basebandSignal, channelAttenuation, noiseVariance);
% channelOutput = basebandSignal;
figure; plotme(tSignal, channelOutput, 'c',...
    'Channel Output', 'time (s)', 'Amplitude');

% Match filtering
% matchFilteredSignal = channelOutput;
matchFilteredSignal = matchFilter(channelOutput, pulseShape);
tSignal = (0: length(matchFilteredSignal)-1)*ts;
figure; plotme(tSignal, matchFilteredSignal, 'c',...
    'Received Signal after Match filtering', 'time (s)', 'Amplitude');

% Sampling
samplingIndices = 1: samples_per_bit: length(matchFilteredSignal)-1;
recvSamples = matchFilteredSignal(samplingIndices);
figure; p = plotme(tSignal, matchFilteredSignal, 'c',...
    'Samples of Match filtered Signal', 'time (s)', 'Amplitude');
p.Color = 'k'; hold on; stem(tSignal(samplingIndices), recvSamples, 'm');

% Conversion to bits followed by Frame detection 
threshold = 0; 
recvBits = decisionMaker(recvSamples, threshold);
[frameIndices, corrResult] = detectFrames(recvBits, frameHeader);
figure; plotme(tb*(0:length(corrResult)-1), corrResult, 'c',...
    'Correlation of received (filtered) signal with Barker Sequence', 'Delay (s)', 'Amplitude');

% % Error analysis
% counter = 1;
% for k = frameIndices
%     recvSignalBitIndices = recvBits(k + headerLength : k + headerLength + frameDataSize-1);
%     if recvSignalBitIndices ~= bits(1 + (counter-1)*frameDataSize: counter*frameDataSize)
%            disp('Error in bits');
%     end
%     counter = counter + 1;
% end

frameDetectionInstants = (frameIndices-1)*tb;
frameStartErrorRate = 1 - length(frameIndices)/numofFrames;
for ii = 1: length(frameDetectionInstants)
    fprintf("Frame #%d detected at %fs\n", ii, frameDetectionInstants(ii));
end
fprintf("\nFrame-start-error-rate = %f\n", frameStartErrorRate);

%% Frame synchronization using autocorrelation: Part 2
numofFrames = 1000;
frameDataSize = 50;
numofbits = numofFrames * frameDataSize;

% Bit sequence generation
rng('default'); s = rng; 
bits = randi([0 1], 1, numofbits);

% Baseband signal generation
impulseTrainForSignal = [];
for iter = 1:numofFrames
    timegapSamples = timegapBetweenFrames(samples_per_bit);
    frameData = bits(1+(iter-1)*frameDataSize : iter*frameDataSize);
    frameBits = [frameHeader, frameData];
    impulseTrainForFrame = bitsToImpulseTrain(frameBits, samples_per_bit);
    impulseTrainForSignal = [impulseTrainForSignal, timegapSamples, impulseTrainForFrame];
end
basebandSignal = impulseTrainToBaseband(impulseTrainForSignal, pulseShape, ts);
tSignal = ts*(0:length(basebandSignal)-1);
figure; plotme(tSignal, basebandSignal, 'c',...
    'Baseband Signal', 'time (s)', 'Amplitude');

% Frame synchronization using autocorrelation
% Channel output
channelAttenuation = 0.6;
noiseVarianceArray = 0: 0.5: 20;
frameStartErrorRate = zeros(1, length(noiseVarianceArray));
for iter = 1: length(noiseVarianceArray)
    channelOutput = idealChannel(basebandSignal, channelAttenuation, noiseVarianceArray(iter));
    % figure; plotme(tSignal, channelOutput, 'c',...
    %     'Channel Output', 'time (s)', 'Amplitude');

    % Match filtering
    % matchFilteredSignal = channelOutput;
    matchFilteredSignal = matchFilter(channelOutput, pulseShape);
    % tSignal = (0: length(matchFilteredSignal)-1)*ts;
    % figure; plotme(tSignal, matchFilteredSignal, 'c',...
    %     'Received Signal after Match filtering', 'time (s)', 'Amplitude');

    % Sampling
    samplingIndices = 1: samples_per_bit: length(matchFilteredSignal)-1;
    recvSamples = matchFilteredSignal(samplingIndices);
    % figure; p = plotme(tSignal, matchFilteredSignal, 'c',...
    %     'Samples of Match filtered Signal', 'time (s)', 'Amplitude');
    % p.Color = 'k'; hold on; stem(tSignal(samplingIndices), recvSamples, 'm');

    % Conversion to bits followed by Frame detection 
    threshold = 0; % not using now
    recvBits = decisionMaker(recvSamples, threshold);
    [frameIndices, corrResult] = detectFrames(recvBits, frameHeader);
    % figure; plotme(tb*(0:length(corrResult)-1), corrResult, 'c',...
    %     'Correlation of received (filtered) signal with Barker Sequence', 'Delay (s)', 'Amplitude');

    frameDetectionInstants = (frameIndices-1)*tb;
    frameStartErrorRate(iter) = 1 - length(frameIndices)/numofFrames;
end
figure; plotme(noiseVarianceArray, frameStartErrorRate, 'c',...
    'Frame-Start-Error-Rate vs \sigma^2', '\sigma^2', 'Frame-Start-Error-Rate');