function bits = sample2bits(samples)
bits = zeros(1, length(samples));
bits(samples > 0) = 1;
end

