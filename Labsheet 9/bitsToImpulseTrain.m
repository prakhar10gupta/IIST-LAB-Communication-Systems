function impulseTrain = bitsToImpulseTrain(bits, upsampleRate)
nBits = length(bits);
impulseTrain = zeros(1, nBits*upsampleRate);
impulseTrain(1: upsampleRate: end) = -1 + 2*bits;
end