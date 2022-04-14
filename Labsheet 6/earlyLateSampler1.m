function [sample, samplingOffset, sampleTimeIndex] = earlyLateSampler1(signal, alpha, delta, clockStartEdge, samples_per_bit, ts)
samplingOffset = floor(samples_per_bit/2);
for ii = 1: 10
    sampleTimeIndex = clockStartEdge + samplingOffset;
    sample = signal(sampleTimeIndex);
    
    earlySampleIndex = sampleTimeIndex - delta;
    if earlySampleIndex < 1
        earlySampleIndex = 1;
    end
    earlySample = signal(earlySampleIndex);
    
    lateSampleIndex = sampleTimeIndex + delta;
    if lateSampleIndex > length(signal)
        lateSampleIndex = length(signal);
    end
    lateSample = signal(lateSampleIndex);
    
    newSamplingOffset = round(samplingOffset - alpha*(abs(earlySample) - abs(lateSample)));
    fprintf("Iteration: %d\nEarly sample at: %f\nMid sample at: %f\nLate sample at: %f\nOffset: %f\n\n",...
        ii, (earlySampleIndex - 1)*ts, (sampleTimeIndex - 1)*ts, (lateSampleIndex - 1)*ts, newSamplingOffset*ts);
    if newSamplingOffset == samplingOffset
        break
    else
        samplingOffset = newSamplingOffset;
    end
end
end