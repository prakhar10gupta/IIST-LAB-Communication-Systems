function [samples, samplingOffset, sampleTimeIndex] = earlyLateSampler2(signal, clock, step_size, delta, threshold, ts)
samples_per_bit = clock(2) - clock(1);
samplingOffset = floor(samples_per_bit/2);
samples = zeros(1, length(clock));
sampleTimeIndex = zeros(1, length(clock));

for ii = 1: length(clock)
    sampleTimeIndex(ii) = clock(ii) + samplingOffset;
%     fprintf("Sampling offset: %d sampletimeindex: %d\n", samplingOffset, sampleTimeIndex(ii));
    samples(ii) = signal(sampleTimeIndex(ii));
    
    earlyTimeIndex = sampleTimeIndex(ii) - delta;
    if earlyTimeIndex < clock(ii)
        earlyTimeIndex = clock(ii);
    end
    earlySample = signal(earlyTimeIndex);
    earlySample = earlySample - threshold;
    
    lateTimeIndex = sampleTimeIndex(ii) + delta;
    if lateTimeIndex > clock(ii) + samples_per_bit -1
        lateTimeIndex = clock(ii) + samples_per_bit -1;
    end
    lateSample = signal(lateTimeIndex);
    lateSample = lateSample - threshold;
    
    samplingOffset = round(samplingOffset - step_size*(abs(earlySample) - abs(lateSample)));
    if samplingOffset > samples_per_bit - 1 % find a better remedy than this
        samplingOffset = samples_per_bit - 1;
    end
 % Include 'ts' in the arguement list and call code for the below to work
%     fprintf("Iteration: %d\nEarly sample at: %f\nMid sample at: %f\nLate sample at: %f\nOffset: %f\n\n",...
%         ii, (earlyTimeIndex - 1)*ts, (sampleTimeIndex(ii) - 1)*ts, (lateTimeIndex - 1)*ts, samplingOffset*ts);
end
end