function pulse = raisedCosinePulse(pulseDuration, tb, fs, a)
A = 1/pi;
% a = 0.6;
ts = 1/fs; % sampling intervals
t = -pulseDuration/2 : ts : pulseDuration/2 - ts;
pulse = A*pi*sinc(t/tb).*cos(pi*a*t/tb)./(1 - (2*a*t/tb).^2);
% if (a~=0 || a==0.2 || a==0.5)
%     pole = find(pulse == Inf | pulse == -Inf)
%     if pole ~= 1
%         pulse(pole) = (pulse(pole-1) + pulse(pole+1))/2;
%     else
%         pulse(pole) = 2*pulse(pole+1) - pole(pulse+2);
% end
% plot(t, pulse);
end