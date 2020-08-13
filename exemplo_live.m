controle 2

exemplo

delta = 0.01;

t = 0:delta:1;
fs = 10;

omega = 2*pi*60;
theta = pi/4;

sinal = e(a*.t).*sin(omega*t+theta);

plot(t,sinal)

fsample = 10Hz
fbase = 20Hz

fsample/ fbase