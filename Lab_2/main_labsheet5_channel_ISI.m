% LABSHEET-5: ISI - Baseband channel
close all; clear; clc;
%% Generating Bits 
nBits = 100; % number of bits
rng('default'); s = rng;
bits = randomBits(nBits);
% disp("Bits generated: "); disp(num2str(bits));

%% Line code parameters
tb = 0.1; % bit rate
fs = 100; ts = 1/fs; % sampling frequency

%% Bits to Baseband
impulseTrain = bits2ImpulseTrain(bits, tb, fs);
pulse = rectPulse(tb, fs);
[basebandSignal, t] = impulse2Baseband(impulseTrain, pulse, fs);
% Plots
figure; p = plotme(t/tb, basebandSignal, 'c', 'Baseband signal (transmit)', 't/tb', 'Amplitude');
p.Color = 'b'; ylim([-1.5, 1.5]); xlim([0, nBits]);
hold on; plot(t/tb, zeros(1, length(t)), '--');
eyediagram(basebandSignal, 2*tb/ts);

%% Channel output and its Eye-diagram
[channelOutput, tchOut] = channel(basebandSignal, fs);
figure; p = plotme(tchOut, channelOutput, 'c', 'Channel Output', 'time (s)', 'Amplitude');
p.Color = 'b';
eyediagram(channelOutput, 2*tb/ts);

%% Matched filter at receiver
% Not yet studied
