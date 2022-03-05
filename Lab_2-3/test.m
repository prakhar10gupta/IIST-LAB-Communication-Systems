% %% Understanding how correlation works
close all; clear; clc;
% corrBits = [1, -1, 1, -1, 1, -1, -1];
% randomBits = randi([-1, 1], 1, 50);
% randomBits = randomBits(randomBits ~= 0);
% lSeq = length(randomBits);
% lCorr = length(corrBits);
% 
% corr = zeros(1, lSeq-lCorr);
% for k = 1:lSeq-lCorr
%     corr(k) = sum(randomBits(k:k+lCorr-1) .* corrBits);
% end
% plot(corr);
% ind = find(corr == max(corr), 1);
% isGuessCorrect = sum(randomBits(ind:ind+lCorr-1) == corrBits) == lCorr

% a = 0.1:0.1:10;
% steps = length(a)/10;
% b = 1./a(1:steps:end);
% plot(a); hold on
% plot(b);