function gapSamples = timegapBetweenFrames(upsampleRate)
timegap = randi([10, 100]);
gapSamples = zeros(1, timegap*upsampleRate);
end