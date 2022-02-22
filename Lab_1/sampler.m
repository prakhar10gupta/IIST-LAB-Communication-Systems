function [samples, samplingInstants] = sampler(receivedSignal, t, tb, ts, N)
indStart = find(receivedSignal < -1 | receivedSignal > 1, 1);
indexSamplingInstants = indStart: tb/ts: indStart + tb*N/ts - 1;
samples = receivedSignal(indexSamplingInstants);
samplingInstants = t(indexSamplingInstants);
end