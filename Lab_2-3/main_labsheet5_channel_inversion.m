% LABSHEET-5: Channel inversion and zero-forcing equalization
close all;
clear; clc;
%% Bits generation
nBits = 1000;
rng('default'); s = rng;
bits = randomBits(nBits);

%% Line code parameters
tb = 0.1; % bit rate
fs = 100; ts = 1/fs; % sampling frequency and period

%% Bits to Baseband
impulseTrain = bits2ImpulseTrain(bits, tb, fs);
pulse = rectPulse(tb, fs);
% pulse = raisedCosinePulse(5*tb, tb, fs, 0.8); % for raised cosine
% pulse = sincPulse(5*tb, tb, fs); % for sinc
% Uncomment the above to see the effect on different pulse types
[basebandSignal, tRect] = impulse2Baseband(impulseTrain, pulse, fs);

% basebandSignal = basebandSignal + -1 + 2*rand([1, length(basebandSignal)]);
% Uncomment the above to see the effect of noise

% Time domain plot
bitLimit = 20;
figure; 
% subplot(3, 1, 1);
p = plotme(tRect/tb, basebandSignal, 'c', ...
    'Baseband signal using rectangular Pulse', 't/tb', 'Amplitude');
p.Color = 'r'; ylim([-1.5, 1.5]); 
%xlim([0, 100]); 
xlim([0, bitLimit]);

%% Non-flat Channel, response and eye diagram
[channelOutput, tChannelOutput, channel, channelDelay] = channelNonflat(basebandSignal, tb, fs);

% Plots of channel response
[H, w] = freqz(channel, 1);
f = w*fs/2/pi;
% figure; subplot(2, 1, 1)
% plotme(f*tb, abs(H), 'c', ...
%     'Magnitude', 'Frequency (\times 1/Tb)', 'Magnitude'); grid on; xlim([0, 2]);
% subplot(2, 1, 2)
% plotme(f*tb, unwrap(angle(H))*180/pi, 'c', ...
%     'Phase', 'Frequency (\times 1/Tb)', 'Angle (deg)'); grid on; xlim([0, 2]);
% sgtitle('Frequency response of Non-flat channel'); 

% Output Time domain plot
figure;
% subplot(3, 1, 2);
tCh = tChannelOutput - channelDelay*ts;
p = plotme(tCh/tb, channelOutput, 'c', ...
    'Non-flat Channel output', 't/tb', 'Amplitude'); 
p.Color = 'b'; xlim([0, bitLimit]);

eyediagram(channelOutput, 2*tb/ts); title('Eye diagram of channel output');


%% Channel inversion equalizer
[rxFilter, rxDelay] = channelInvFilter(channel);
[Hfilter, w] = freqz(rxFilter, 1);
f = w*fs/2/pi;

% Plots
% figure;
% subplot(2, 1, 1)
% plotme(f*tb, (abs(Hfilter)), 'c', ...
%     'Magnitude', 'Frequency (\times 1/Tb)', 'Magnitude'); grid on; xlim([0, 2]);
% subplot(2, 1, 2)
% plotme(f*tb, unwrap(angle(Hfilter))*180/pi, 'c', ...
%     'Phase', 'Frequency (\times 1/Tb)', 'Angle (deg)'); grid on; xlim([0, 2]);
% sgtitle('Frequency response of the equalizer');  

% Checking inversion
figure;
plotme(f*tb, abs(H).*abs(Hfilter), 'c', ...
    'Point-wise product of Channel and Equalizer frequency response',...
    'Frequency (\times 1/Tb)', '|H_{channel}| * |H_{equalizer}|');
hold on; 
plot(f*tb, ones(1, length(f)), 'r--'); hold off;

rxOutput = conv(channelOutput, rxFilter);

% Time domain plot
tOut = (0 : length(rxOutput) - 1)*ts - (rxDelay + channelDelay)*ts;
figure;
% subplot(3, 1, 3);
p = plotme(tOut/tb, rxOutput, 'c', ...
    'Channel inversion equalizer output', 't/tb', 'Amplitude'); 
p.Color = 'm'; xlim([0, bitLimit]);

% eyediagram(rxOutput, 2*tb/ts); title('Eye diagram of inversion filter output');

%% Tapped delay Zero-forcing equalizer
samplesPerPulse = tb/ts;
[refForFilter, ~, ~, chDelay] = channelNonflat(pulse, tb, fs);
% figure; plot(refForFilter); title('Reference signal m(t) = p(t)*h(t)');

N = 50;
[zfFilterWeights, eqzDelay] = zeroForcingFilter(N, refForFilter, chDelay, samplesPerPulse);
% figure; stem(-N:N, zfFilterWeights); title(strcat('Filter weights for N = ', num2str(N)));
zfFilter = upsampler(zfFilterWeights, tb, fs);
% figure; stem(zfFilter); title('Linear Tapped Delay line Zero-Forcing filter');

filterOutput = conv(channelOutput, zfFilter);
t = (0: length(filterOutput)-1)*ts;

% manuallyFoundDealy = (eqzDelay + channelDelay + 169)*ts;
% tplot = t - manuallyFoundDealy;
% figure; p = plotme(tplot/tb, filterOutput, 'c', ...
%     strcat('Zero-forcing Equalilzer output for N = ', num2str(N)), 't/tb', 'Amplitude'); 
% p.Color = 'b'; xlim([0, bitLimit]);
txt = strcat(['Eye diagram of zero-forcing filter output for N = ', num2str(N)]);
eyediagram(filterOutput, 2*tb/ts); title(txt);