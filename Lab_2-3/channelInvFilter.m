function [filter, delay] = channelInvFilter(channel)
[H, w] = freqz(channel, 1);
% Taking samples of channel spectrum
endlen = length(H)/2.5; % at H/2, it takes 0 values, so taking inverse won't be wise option
step = floor(endlen/50);
samples = 1: step : endlen;
magSamples = abs(H(samples)');
magSamples = [1./magSamples, 0];
fSamples = [w(samples)'/pi, 1];
order = 99;
filter = fir2(order, fSamples, magSamples);
delay = (order+1)/2;
end