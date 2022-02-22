% LABSHEET-5: Pulse Shaping
close all;
clear; clc;
%% Bits generation
nBits = 1000;
rng('default'); s = rng;
bits = randomBits(nBits);

%% Line code parameters
tb = 0.2; % bit rate
fs = 100; ts = 1/fs; % sampling frequency

%% Bits to Rectangular Baseband
impulseTrain = bits2ImpulseTrain(bits, tb, fs);
rectPulse = rectPulse(tb, fs);
[basebandRect, tRect] = impulse2Baseband(impulseTrain, rectPulse, fs);
figure; sgtitle('Baseband signal using different pulse types'); 
subplot(3, 1, 1); p = plotme(tRect/tb, basebandRect, 'c', ...
    'Rectangular Pulse', 't/tb', 'Amplitude');
p.Color = 'r'; ylim([-1.5, 1.5]); xlim([0, nBits/10]);

%% Bits to Sinc Baseband
sincPulse = sincPulse(5*tb, tb, fs);
[basebandSinc, tSinc] = impulse2Baseband(impulseTrain, sincPulse, fs);
subplot(3, 1, 2); p = plotme(tSinc/tb, basebandSinc, 'c', ...
    'Sinc Pulse', 't/tb', 'Amplitude');
p.Color = 'b'; xlim([0, nBits/10]); % ylim([-1.5, 1.5]);

%% Bits to Raised Cosine Baseband
rcPulse = raisedCosinePulse(5*tb, tb, fs, 0.75);
[basebandrc, trc] = impulse2Baseband(impulseTrain, rcPulse, fs);
subplot(3, 1, 3); p = plotme(trc/tb, basebandrc, 'c', ...
    'Raised Cosine Pulse', 't/tb', 'Amplitude');
p.Color = 'g'; xlim([0, nBits/10]); % ylim([-1.5, 1.5]);

%% PSD of the baseband signals
% [psdRect, w] = pwelch(basebandRect);
% psdSinc = pwelch(basebandSinc);
% psdrc = pwelch(basebandrc);
% figure
% subplot(3, 1, 1); plotme(w/(2*pi)*fs, psdRect, 'c', ...
%     'Rectangular Baseband', 'Frequency (Hz)', 'PSD (W/Hz/(rad/sample))'); 
% subplot(3, 1, 2); plotme(w/(2*pi)*fs, psdSinc, 'c', ...
%     'Sinc Baseband', 'Frequency (Hz)', 'PSD (W/Hz/(rad/sample))');
% subplot(3, 1, 3); plotme(w/(2*pi)*fs, psdrc, 'c', ...
%     'Raised Cosine Baseband', 'Frequency (Hz)', 'PSD (W/Hz/(rad/sample))');  
% sgtitle('Power Spectral Density estimation using Welch method')

%% Eye diagrams
% eyediagram(basebandRect, 2*tb/ts); title('Eye diagram for Rectangular signal');
% eyediagram(basebanbasebandSinc, 2*tb/ts); title('Eye diagram for Sinc signal');
% eyediagram(basebandrc, 2*tb/ts); title('Eye diagram for Raised Cosine signal');

%% Spectra and Eye diagrams of RC wave for different 'a'
% figure;
% for a = 0.1: 0.3: 1
%     rcPulse = raisedCosinePulse(5*tb, tb, fs, a);
%     [basebandrc, trc] = impulse2Baseband(impulseTrain, rcPulse, fs);
%     Bf = fft(basebandrc);
%     f = fs/length(basebandrc)*(0:1:length(basebandrc)-1);
%     % subplot(5, 1, 1+a/0.25);
%     nexttile;
%     p = plotme(f, abs(Bf), 'c', ...
%     strcat('\alpha = ', num2str(a)), 'Frequency (Hz)', 'Magnitude');
%     xlim([0, fs/2])
%     hold on
% end
% sgtitle('Magnitude spectrum for different \alpha values');
% hold off

%% Channel Output
[chOutRect, tRect, chDelay] = channel(basebandRect, fs);
[chOutSinc, tSinc] = channel(basebandSinc, fs);
[chOutrc, trc] = channel(basebandrc, fs);

% figure; sgtitle('Channel output of the baseband signals'); 
% subplot(3, 1, 1); p = plotme(tRect/tb, chOutRect, 'c', ...
%     'Rectangular signal', 't/tb', 'Amplitude');
% p.Color = 'r'; ylim([-1.5, 1.5]); xlim([0, nBits/10]);
% 
% subplot(3, 1, 2); p = plotme(tSinc/tb, chOutSinc, 'c', ...
%     'Sinc signal', 't/tb', 'Amplitude');
% p.Color = 'b'; xlim([0, nBits/10]); % ylim([-1.5, 1.5]);
% 
% subplot(3, 1, 3); p = plotme(trc/tb, chOutrc, 'c', ...
%     'Raised Cosine signal', 't/tb', 'Amplitude');
% p.Color = 'g'; xlim([0, nBits/10]); % ylim([-1.5, 1.5]);

%% PSD and eye diagram of channel outputs
[psdRect, w] = pwelch(chOutRect);
psdSinc = pwelch(chOutSinc);
psdrc = pwelch(chOutrc);
% figure
% subplot(3, 1, 1); plotme(w/(2*pi)*fs, psdRect, 'c', ...
%     'Rectangular signal', 'Frequency (Hz)', 'PSD (W/Hz/(rad/sample))'); 
% subplot(3, 1, 2); plotme(w/(2*pi)*fs, psdSinc, 'c', ...
%     'Sinc signal', 'Frequency (Hz)', 'PSD (W/Hz/(rad/sample))');
% subplot(3, 1, 3); plotme(w/(2*pi)*fs, psdrc, 'c', ...
%     'Raised Cosine signal', 'Frequency (Hz)', 'PSD (W/Hz/(rad/sample))');  
% sgtitle('Power Spectral Density estimation of channel outputs using Welch method')

% eyediagram(chOutRect, 2*tb/ts); title('Eye diagram for Rectangular signal');
% eyediagram(chOutSinc, 2*tb/ts); title('Eye diagram for Sinc signal');
% eyediagram(chOutrc, 2*tb/ts); title('Eye diagram for Raised Cosine signal');
