function bits = randomBits(N)
bits = randi([0, 1], 1, N);
disp("Bits generated: ");
disp(num2str(bits));
end

