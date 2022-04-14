function bits = decisionMaker(samples, threshold)
% samples(abs(samples) < 1e-5) = 0; % To get rid of the problem of storing 0 as +-1e-15 in MATLAB
bits = samples > threshold;
bits = bits + 0;
end