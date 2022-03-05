function p = plotme(xdata, ydata, type, titletxt, xlabeltxt, ylabeltxt)
if type == 'c'
    p = plot(xdata, ydata);
elseif type == 'd'
    p = stem(xdata, ydata); 
else
    disp('Error in input type of plot')
end
title(titletxt)
xlabel(xlabeltxt); ylabel(ylabeltxt);
end