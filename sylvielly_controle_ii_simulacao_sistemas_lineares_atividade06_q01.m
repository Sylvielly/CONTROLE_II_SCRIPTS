%===============================================================================
%CONTROLE II
%AUTORA: SYLVIELLY S. SOUSA                           %MATRICULA: 20162045070410
%SEMESTRE 2020.1          
%PROF.: LUIZ DANIEL BEZERRA
%ATIVIDADE 06: SIMULACAO DE SISTEMAS LINEARES               %ENTREGA: 10/09/2020
%===============================================================================

close all
clear all 
clc

%===================================PROMPT======================================

disp("========================================================================")
disp("                           CONTROLE II                                  ")                      
disp("                         CONTROLADOR PID                                ")                                                                  
disp("                   SIMULACAO DE SISTEMAS LINEARES                       ")                        
disp("========================================================================")

Kp = input("\tCOEF. PROPORCIONAL                 Kp =      ");
Ki = input("\tCOEF. INTEGRAL                     Ki =     ");
Kd = input("\tCOEF. DERIVATIVO                   Kd =     ");
fs = input("\tFREQ DE AMOSTRAGEM [Hz]            fs  =     ");

%===============================================================================
%                                   DADOS  
%===============================================================================

pkg load signal
pkg load control
pkg load symbolic

numerador = [0 0.5151 -0.1452 -0.2963 0.0528];
denominador = [1 -1.8528 1.5906 -0.6642 0.0528];

disp("========================================================================")
disp("        Funcao de Transferencia F(z) = C(z)/R(z) pre-definida");
disp("========================================================================")

ts = 1/fs;                                      %tempo de amostragem [s]
npts = 5;                                       %numero de pontos para plotagem
z = tf('z',ts);
numerador = ((0.5151*z^3) - (0.1452*z^2) -(0.2963*z) + 0.0528);
denominador = (z^4 - (1.8528*z^3) + (1.5906*z^2) - (0.6642*z) + 0.0528);

F_z = numerador/denominador

disp("========================================================================")
disp("                         Controlador PID(z)");
disp("========================================================================")

PID = (Kp + (Ki/(1-(1/z))) + Kd*(1 - (1/z)))    %controlador PID(z)
%a partir da transformada inversa de Laplace para o produto de ZOH e Gh_s 
%[ZOH*Gh_s], aplica-se a transformada Z para ambos, tendo como resultado G_z

disp("========================================================================")
disp("                              G(z)");
disp("========================================================================")

G_z = ((0.3679*(1/z)) + (0.2642*(1/z^2))) / ((1 - 0.3679*(1/z))*(1-(1/z)))
disp("========================================================================")
disp("                             Saída C(z)");
disp("========================================================================")

C_z = (PID*G_z) / (1+ (PID*G_z))

%===============================================================================
%                           GERACAO DE GRAFICOS  
%===============================================================================
figure(1)
subplot(2,2,1)   
step(F_z,npts,'r')         
grid on
title('Grafico da F(z) em degrau','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('F(z)', 'FontName','Times','FontSize',18);

subplot(2,2,3)   
step(C_z,npts,'b')         
grid on
title('Grafico da saída C(z) em degrau','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('C(z)', 'FontName','Times','FontSize',18);

figure(2)
subplot(2,2,1)   
ramp(F_z,npts,'r')         
grid on
title('Grafico da F(z) em rampa','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('F(z)', 'FontName','Times','FontSize',18);

subplot(2,2,3)   
ramp(C_z,npts,'b')         
grid on
title('Grafico da saída C(z) em rampa','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('C(z)', 'FontName','Times','FontSize',18);

figure(3)
subplot(2,2,1)   
step(PID,'m')         
grid on
title('Grafico da PID em degrau','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('PID', 'FontName','Times','FontSize',18);

subplot(2,2,3)   
ramp(PID,'k')         
grid on
title('Grafico da PID em rampa','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('PID', 'FontName','Times','FontSize',18);
