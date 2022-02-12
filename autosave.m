% Autosave
function autosave(name, path)
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gca, path + '\' + name + '.png' ,'png'); 
end