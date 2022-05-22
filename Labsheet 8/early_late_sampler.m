function [samples, sampling_times] = early_late_sampler(baseband_signal, sampling_frequency, bit_time, initial_clock_edge, earlylate_delta, stepsize, threshold)

samples = [];
sampling_times = [];
num_samples_in_bit = bit_time * sampling_frequency;
sampling_offset = floor(num_samples_in_bit/2);
clock_edge = initial_clock_edge;

early_sampling_offset = sampling_offset - earlylate_delta;
if early_sampling_offset < 0
    early_sampling_offset = 0;
end
if early_sampling_offset > num_samples_in_bit - 1
    early_sampling_offset = num_samples_in_bit - 1;
end
late_sampling_offset = sampling_offset + earlylate_delta;
if late_sampling_offset < 0
    late_sampling_offset = 0;
end
if late_sampling_offset > num_samples_in_bit - 1
    late_sampling_offset = num_samples_in_bit - 1;
end

while (clock_edge + num_samples_in_bit - 1 < length(baseband_signal))
    sampling_time = clock_edge + sampling_offset;
    early_sample_time = clock_edge + early_sampling_offset;
    late_sample_time = clock_edge + late_sampling_offset;
   
    sampling_times = [sampling_times, sampling_time];
    samples = [samples, baseband_signal(sampling_time)];
    
    early_sample = baseband_signal(early_sample_time) - threshold;
    late_sample = baseband_signal(late_sample_time) - threshold;
    early_sample = abs(early_sample);
    late_sample = abs(late_sample);
    
    clock_edge = clock_edge + num_samples_in_bit;
    if early_sample < late_sample
        clock_edge = clock_edge + stepsize * (late_sample - early_sample);
    elseif early_sample > late_sample
        clock_edge = clock_edge + stepsize * (late_sample - early_sample);
    end
    clock_edge = round(clock_edge);
end