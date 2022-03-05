function pulse = rectPulse(pulseDuration, fs)
ts = 1/fs;
t = -pulseDuration/2 : ts : pulseDuration/2 - ts;
pulse = ones(1, length(t));
end