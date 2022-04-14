close all; clear; clc;
a = [1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0];
a(a==0) = -1;
filter = ones(1, 3);
[c, lags] = xcorr(a, filter);
% plot(lags, c)
corr = c(lags >=0);
plot(corr)