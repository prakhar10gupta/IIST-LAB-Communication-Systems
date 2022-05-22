function [frameIndices, corrResult] = detectFrames(givenBits, refBits)
givenBits(givenBits==0) = -1;
refBits(refBits==0) = -1;
corrResult = my_autocorr(givenBits, refBits); % user-defined function
frameIndices = find(corrResult == length(refBits));
end

% Error check
% framesCheck = diff(frameIndices);
% frameIndices = frameIndices(framesCheck > length(refBits) + 10); 
% 10 is the length of seq of alternating 1s and 0s

% Using in-built functions
% [corrResult, lags] = xcorr(givenBits, refBits);
% corrFromZero = corrResult(find(lags == 0): end);
% frameIndices = find(abs(corrFromZero - 13) < 1);
