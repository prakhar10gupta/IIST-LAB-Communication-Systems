function [basebandSignal, tBBsignal] = impulse2Baseband(impulseTrain, pulse, fs)
basebandSignal = conv(impulseTrain, pulse);
ts = 1/fs;
tBBsignal = (0 : length(basebandSignal) - 1)*ts;
end