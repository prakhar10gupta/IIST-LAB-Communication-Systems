function channelOutput = idealChannel(input, attenuation, noiseVariance)
channelOutput = input*attenuation;
channelOutput = channelOutput + randn(1, length(channelOutput))*sqrt(noiseVariance);

% % Practical code
% n = 99; % keep it odd
% A = attenuation* [1, 1, 0, 0];
% f = [0, 50/tb, 60/tb, 1];
% channel = fir2(n, f, A);
% freqz(channel, 1);
% output = conv(input, channel);
% delay = (n+1)/2;
% channelOutput = output(delay:end);
end