#IFCE campus Maracanaú
#Eng. de Controle e Automação - Controle II
#Magna Vitaliano - 20162045070461
#GNU Octave versão 5.2.0

clear
close all
clc

%
a1=1.5;       
a2=-0.7;

b1=1;
b2=0.5;

%Ganho CC
Vcc = (b1+b2) / (1 - a1 - a2)

%atrasos solicitados no exercicio
atraso1=1;   
atraso2=3;   
atraso3=5;   

%Degrau unitário atrasado em 10
u=vertcat(zeros(10,1),ones(40,1)); %Os 10 primeiros valores são zero
                                   %e o 40 valores seguintes são 1

%------------------------------------------------------------------
%Vetor de zeros com mesmas dimensões de u                  
y=zeros(size(u));

for k = (atraso3+2):length(u)
  y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-atraso1) + b2*u(k-(atraso1+1));
endfor

y1=y;

%-------------------------------------------------------------------
%Vetor de zeros com mesmas dimensões de u                  
y=zeros(size(u));

for k = (atraso3+2):length(u)
  y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-atraso2) + b2*u(k-(atraso2+1));
endfor

y2 = y;
%-------------------------------------------------------------------
%Vetor de zeros com mesmas dimensões de u                  
y=zeros(size(u));

for k = (atraso3+2):length(u)
  y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-atraso3) + b2*u(k-(atraso3+1));
endfor

y3 = y;

figure(1)
plot(y1,"or;y1: com atraso puro = 1;",y2,"*b;y2: com atraso puro = 3;",y3,"dm;y3: com atraso puro = 5;")
