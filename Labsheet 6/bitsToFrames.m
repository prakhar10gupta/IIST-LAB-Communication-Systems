function frames = bitsToFrames(bits, header)
frameSize = length(header) + 50; %% assuming 50 data bits in a frame
numFrames = length(bits)/50;
frames = zeros(numFrames , frameSize);
for ii = 1: numFrames 
    frames(ii, :) = [header, bits(1 + (ii-1)*50: ii*50)];
end
end

