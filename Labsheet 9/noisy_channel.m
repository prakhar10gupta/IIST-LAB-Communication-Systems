function output = noisy_channel(input, attenuation, noiseVariance)
output = input*attenuation;
output = output + randn(1, length(output))*sqrt(noiseVariance);

end