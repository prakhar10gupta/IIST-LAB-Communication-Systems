function symbols = generate_constellation_symbols(i, q)
% Returns constellation symbols for QAM schemes
symbols = [];
for ii = 1: length(i)
    for jj = 1: length(q)
        symbols = [symbols; [i(ii), q(jj)]];
    end
end
end