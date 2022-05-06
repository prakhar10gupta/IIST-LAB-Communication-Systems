function [basebandSignal, tSignal] = impulseTrainToBaseband(impulseTrain, pulseShape, ts) 
basebandSignal = conv(impulseTrain, pulseShape);
tSignal = (0 : length(basebandSignal) - 1)*ts;
end