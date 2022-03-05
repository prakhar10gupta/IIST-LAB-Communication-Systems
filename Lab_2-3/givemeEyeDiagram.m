function givemeEyeDiagram(signal, t, pulseDuration, ts, period)
    t_add = -pulseDuration/2: ts: -ts;
    t_new = [t_add, t];
    signal_new = [zeros(1, length(t_add)), signal];
    samples = floor(period/ts);
    curves = floor(length(signal_new)/samples);
    figure
    hold on
    for k = 1: curves
        p = plot(t_new(1:samples)/pulseDuration, signal_new(1 + (k-1)*samples: k*samples), 'b');
%         pause(0.1);
    end
    xlim([-0.5, t_new(samples)/pulseDuration]);
    xlabel('Normalised time (t/pulseDuration)'); ylabel('Amplitude');
    title('Eye Diagram');
    hold off
end