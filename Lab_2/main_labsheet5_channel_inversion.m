% LABSHEET-5: Channel inversion
close all; clear; clc;
%% Bit generation
N = 100;
fs = 100;
ts = 1/fs;
rng('default'); s = rng;
bits = randomBits(N);

%% BPSK signal generation
tb = 0.1;
% [signal, t] = linecoder(bits, pulseType, tb, pulseDuration, fs)
[bbRect, tRect] = linecoder(bits, 'rect', tb, tb, fs);
figure; plotme(tRect, bbRect, 'c', "Baseband signal using Rectangular pulse", 'time', 'Amplitude');
ylim([-1.5, 1.5]);

%% Channel output 
[channelOutput, tChannelOutput, channelDelay, channel] = channelNonflat(bbRect, tb, fs);
givemeEyeDiagram(channelOutput, tChannelOutput, tb, ts, 2*tb);

%% Equalizer
equalizer(channel);
