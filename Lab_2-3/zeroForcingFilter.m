function [filterWeights, delay] = zeroForcingFilter(N, refSignal, nref, samplesPerPulse)
requiredMinLength = (2*(2*N+1)+1)*samplesPerPulse;
extralength = length(refSignal) - requiredMinLength;
extra = ceil(-extralength/2);
if extralength < 0
    refSignal = [zeros(1, extra), refSignal, zeros(1, extra)];
    nref = nref + extra;
end

% Obatining samples of the received signal
[signalSamples, sampleref] = samplerForRefsignalZF(refSignal, nref, samplesPerPulse);
% figure; stem(signalSamples); title('Samples of reference signal at Tb intervals')

% Filter synthesis
numofwts = 2*N+1;
A = zeros(numofwts);
% for k = 1:numofwts
%     A(k, :) = [flip(signalSamples(sampleref: sampleref + (k-1))), signalSamples(sampleref-1:-1:sampleref-(numofwts-k))];
% end
for k = 1:numofwts
    A(k, k) = signalSamples(sampleref);
    for m = 1: numofwts-k
        A(k+m, k) = signalSamples(sampleref+m); 
        A(k, k+m) = signalSamples(sampleref-m);
    end
end
B = zeros(numofwts, 1);
B((numofwts-1)/2) = 1;
filterWeights = A\B; % AX = B => X = inv(A)*B
delay = (numofwts+1)/2;
end