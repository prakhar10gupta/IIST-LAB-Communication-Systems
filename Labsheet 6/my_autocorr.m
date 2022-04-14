function corrResult = my_autocorr(signal, ref)
% assuming ref is smaller signal
lenSignal = length(signal);
lenRef = length(ref);
if lenSignal < lenRef
    error("Swap the Input arguements of my_autocorr");
end
corrResult = zeros(1, lenSignal - lenRef + 1);
for ii = 1: lenSignal - lenRef + 1
    corrResult(ii) = sum(signal(ii: ii + lenRef-1) .* ref);
end
end

