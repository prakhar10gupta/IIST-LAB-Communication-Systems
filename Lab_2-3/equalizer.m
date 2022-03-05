function filter = channelInvFilter(channel)
[channelSpectrum, w] = freqz(channel, 1);
plot(w/(2*pi), abs(channelSpectrum));
end