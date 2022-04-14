function [samples, samplingOffset, sampleTimeIndex] = earlyLateSampler2(signal, clock, alpha, delta, ts)
samples_per_bit = clock(2) - clock(1);
samplingOffset = floor(samples_per_bit/2);
samples = zeros(1, length(clock));
sampleTimeIndex = zeros(1, length(clock));

for ii = 1: length(clock)
    sampleTimeIndex(ii) = clock(ii) + samplingOffset;
%     fprintf("Sampling offset: %d sampletimeindex: %d\n", samplingOffset, sampleTimeIndex(ii));
    samples(ii) = signal(sampleTimeIndex(ii));
    
    earlySampleIndex = sampleTimeIndex(ii) - delta;
    if earlySampleIndex < clock(ii)
%         earlySampleIndex = clock(ii);
    end
    earlySample = signal(earlySampleIndex);
    
    lateSampleIndex = sampleTimeIndex(ii) + delta;
    if lateSampleIndex > clock(ii) + samples_per_bit -1
        lateSampleIndex = clock(ii) + samples_per_bit -1;
    end
    lateSample = signal(lateSampleIndex);
    
    samplingOffset = round(samplingOffset - alpha*(abs(earlySample) - abs(lateSample)));
    if samplingOffset > samples_per_bit % find a better remedy than this
        samplingOffset = samples_per_bit;
    end
 % Include 'ts' in the arguement list and call code for the below to work
%     fprintf("Iteration: %d\nEarly sample at: %f\nMid sample at: %f\nLate sample at: %f\nOffset: %f\n\n",...
%         ii, (earlySampleIndex - 1)*ts, (sampleTimeIndex(ii) - 1)*ts, (lateSampleIndex - 1)*ts, samplingOffset*ts);
end
end