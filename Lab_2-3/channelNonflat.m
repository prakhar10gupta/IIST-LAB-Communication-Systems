function [outputSignal, t, channel, delay] = channelNonflat(inputSignal, tb, fs)
order = 999;
amplitudes = [1, 0.7, 0.9, 0.3, 0.5, 0, 0];
frequencySamples = [0, 1/8, 1/4, 1/2, 1, 2]/tb;
frequencySamples = [frequencySamples/(fs/2), 1];
channel = fir2(order, frequencySamples, amplitudes);
outputSignal = conv(inputSignal, channel);
t = 1/fs * (0: 1: length(outputSignal) - 1);
delay = (order+1)/2 + 7;
end