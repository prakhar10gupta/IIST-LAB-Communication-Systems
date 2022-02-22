% Low pass filter implementation of ideal baseband channel
function [channelOutput, tchOut, delay] = channel(inputSignal, fs)
order = 99;
fpass = 10; % passband cutoff fc
fstop = 20; % stopband cutoff
frequencySamples = [0, fpass, fstop, fs/2]/(fs/2);
g = 1; % passband gain
amplitudes = [g, g, 0, 0];
channel = fir2(order, frequencySamples, amplitudes); % filter impulse response
% fvtool(channel, 1);
title('Frequency response of baseband channel')
channelOutput = conv(inputSignal, channel);
ts = 1/fs;
tchOut = 0: ts: (length(channelOutput) - 1)* ts;
delay = (order+1)/2;
end

