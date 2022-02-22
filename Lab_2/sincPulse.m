function pulse = sincPulse(pulseDuration, tb, fs)
A = 1/pi;
ts = 1/fs; % sampling intervals
t = -pulseDuration/2 : ts : pulseDuration/2 - ts;
pulse = A*pi*sinc(t/tb);
% plot(t, pulse)
end