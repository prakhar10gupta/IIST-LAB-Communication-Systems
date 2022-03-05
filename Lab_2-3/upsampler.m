function upsampledSignal = upsampler(signal, tb, fs)
samplesPerPulse = tb*fs;
numofsamples = length(signal)*samplesPerPulse;
upsampledSignal = zeros(1, numofsamples);
upsampledSignal(1: samplesPerPulse: end) = signal;
end