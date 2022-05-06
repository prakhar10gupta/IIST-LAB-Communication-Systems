function bits = symbol_to_bits_psk8(symbol)
vector = symbol(1) + 1i*symbol(2);
angle_vector = angle(vector);
if angle_vector < 0
    angle_vector = angle_vector + 2*pi;
end
angle_index = floor(angle_vector/(2*pi/8));
bits = de2bi(angle_index, 3, 'left-msb');
end