function rn = receiveFilter(fs)
fpass = 20;
fstop = 30;
g = 1;
f = [0, [fpass, fstop]/(fs/2), 1];
a = g*[1, 1, 0, 0];
rn = firpm(100, f, a);
end