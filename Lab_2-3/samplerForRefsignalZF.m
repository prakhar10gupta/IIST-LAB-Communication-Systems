function [signalSamples, sampleref] = samplerForRefsignalZF(refSignal, nref, samplesPerPulse)
nPlus = floor((length(refSignal) - nref)/samplesPerPulse);
nMinus = floor(nref/samplesPerPulse);
numofsamples = nPlus + nMinus + 1;
signalSamples = zeros(1, numofsamples);
for ii = 1: nMinus
    signalSamples(ii) = refSignal(1 + (ii-1)*samplesPerPulse);
end
for ii = nMinus + 1: numofsamples
    signalSamples(ii) = refSignal(nref + (ii - (nMinus + 1))*samplesPerPulse);
end
sampleref = nMinus + 1;
end