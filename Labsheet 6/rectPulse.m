function [pulse, t] = rectPulse(amplitude, pulseDuration, ts)
t = -pulseDuration/2 : ts : pulseDuration/2 - ts;
pulse = amplitude*ones(1, length(t));
end