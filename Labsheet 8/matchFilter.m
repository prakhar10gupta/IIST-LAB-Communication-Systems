function output = matchFilter(input, pulseShape)
if pulseShape ~= ones(1, length(pulseShape))
    error('Change the code of Match filter according to pulse shape chosen');
end
%% Works well for rect pulse
filter = pulseShape;
samplesPerBit = length(pulseShape);
output = 1/samplesPerBit* conv(input, filter);

%% Below code Works for any pulse shape
% [corrResult, lags] = xcorr(input, filter);
% output = corrResult(find(lags==0):end);
end