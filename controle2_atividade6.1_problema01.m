#IFCE campus Maracanaú
#Eng. de Controle e Automação - Controle II
#Magna Vitaliano - 20162045070461
#GNU Octave versão 5.2.0

clear
close all
clc

T=0.1;
Kp=1;
Ki = 0.2;
Kd = 0.2;
Nmax = 40;

pkg load control

z=tf('z',T);

Gz = ((0.3679*(z^-1)) + (0.2642*(z^-2))) / ((1 - 0.3679*(z^-1))*(1-(z^-1)))

Gd = Kp + (Ki/(1-(z^-1))) + (Kd*(1-(z^-1)))

Ck = (Gd*Gz) / (1+ (Gd*Gz))

figure(1)
%Resposta ao degrau
subplot(1,2,1)
step(Ck,Nmax)
ylabel("c(k)")
xlabel("k")

%Resposta a rampa
subplot(1,2,2)
ramp(Ck,Nmax)
ylabel("c(k)")
xlabel("k")
