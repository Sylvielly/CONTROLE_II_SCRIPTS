%===============================================================================
%CONTROLE II
%AUTORA: SYLVIELLY S. SOUSA                           %MATRICULA: 20162045070410
%SEMESTRE 2020.1          
%PROF.: LUIZ DANIEL BEZERRA
%ATIVIDADE 01: TEOREMA DA AMOSTRAGEM                  %ENTREGA: 13/08/2020
%===============================================================================

close all
clear all 
clc

%Conceba um script no MATLAB/SCILAB que proporcione uma forma de visualizar um 
%sinal continuo do tipo:
                  
                      %f = (e^(-at))*sin(2*pi*f0*t);

%e, a sua discretizacao para apos um modulador do tipo impulsivo, de forma tal que o
%script permita variacao do angulo em que e iniciada a amostragem, e da relacao entre
%frequencia fundamental f0 e a frequencia de amostragem fs . (Utilize a funcao stem()
%para visualizar e comparar os efeitos)
%%

%===================================PROMPT======================================

disp("========================================================================")
disp("//\t SCRIPT PARA PLOTAR O GRAFICO DO SINAL                              ")                      
disp("//                                                                    //")                                                                  
disp("//\t f(t) = f = (e^(-at))*sin(2*pi*f0*t)                                ")                        
disp("//                                                                    //")                                                              
disp("========================================================================")

a = input("\tINSIRA UM COEF. DE DECAIMENTO EXPONENCIAL        a =      ");
f0 = input("\tINSIRA UMA FREQ FUNDAMENTAL                     f0 =     ");
fs = input("\tINSIRA UMA FREQ DE AMOSTRAGEM [MIN. 2xf0]       fs =     ");
theta = input("\tINSIRA UM ANGULO ENTRE 0 E 90 GRAUS          theta =  ");

%===============================================================================
%                                 CALCULOS  
%===============================================================================
t = 0:1/fs:1;                   %tempo de simulacao a partir da taxa de amost.
w0 = 2*pi*f0;                   %frequencia angular fundamental [rad/s]
fs_40 = 0.4*f0;                 %frequencia de amostragem reduzida 40% em [Hz]
fs_60 = 0.6*f0;                 %frequencia de amostragem reduzida 60% em [Hz]
fs_2 = 2*f0;                    %frequencia de amostragem aumentada 2*f0 em [Hz]
fs_20 = 20*f0;                  %frequencia de amostragem aumentada 20*f0 em [Hz]
theta_rad = ((theta*pi)/180);   %angulo em radianos
t_angulo = theta_rad/w0;        %variacao de tempo a partir do angulo
  
   %funcao = (exp(-a.*t)).*sin(w0*t+theta);       %em caso de utilizacao no matlab
   funcao = (e.^(-a*t)).*sin(w0*t);              %em caso de utilizacao no octave 

%tempos calculados a partir da solicitacao de mudanca na taxa de amostragem
  t_40 = 0:1/fs_40:1;
  t_60 = 0:1/fs_60:1;
  t_2f0 = 0:1/fs_2:1;
  t_20f0 = 0:1/fs_20:1;
%tempos calculados a partir da solicitacao de mudanca no angulo de fase
  t_novo = 0:t_angulo:1;
%funcao com reducao na taxa de amostragem   
  amostragem_40 = (e.^(-a*t_40)).*sin(w0*t_40);
  amostragem_60 = (e.^(-a*t_60)).*sin(w0*t_60);
%funcao com aumento na taxa de amostragem   
  amostragem_2_f0 = (e.^(-a*t_2f0)).*sin(w0*t_2f0);
  amostragem_20_f0 = (e.^(-a*t_20f0)).*sin(w0*t_20f0);
%funcao com variacao de angulo
  amostragem_angulo = (e.^(-a*t)).*sin((w0*t)+theta_rad);
%funcao com reducao na taxa de amostragem e variacao de angulo
  amostragem_ang_40 = (e.^(-a*t_40)).*sin((w0*t_40)+theta_rad);
%funcao com aumento na taxa de amostragem e variacao de angulo
  amostragem_ang_20f0 = (e.^(-a*t_20f0)).*sin((w0*t_20f0)+theta_rad);

%===============================================================================
%                           GERACAO DE GRAFICOS  
%===============================================================================
%grafico em tempo continuo
figure(1)                 
subplot(2,1,1)   
plot(t,funcao,'b','LineWidth',3)         
grid on
title('Grafico da f(t) no dominio do tempo continuo','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);
%grafico em tempo discreto
subplot(2,1,2)   
stem(funcao,'r','LineWidth',3)         
grid on
title('Grafico de f[n] no dominio do tempo discreto','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);
%===============================================================================   
if (fs<f0)              
%1. Exibindo os resultados para alguns valores de fs<f0. (Sugest�o: fs=40%f0; fs=60%f0)
figure(2)
subplot(2,2,1)   
plot(t_40,amostragem_40,'b','LineWidth',3)            %funcao continua no tempo
grid on
title('Grafico da f(t) tempo continuo com fs = 0.4*f0','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);

subplot(2,2,3)   
stem(t_40,amostragem_40,'r','LineWidth',3)            %funcao discretizada no tempo
grid on
title('Grafico da f[n] tempo discreto com fs = 0.4*f0','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);

subplot(2,2,2)   
plot(t_60,amostragem_60,'b','LineWidth',3)             %funcao continua no tempo
grid on
title('Grafico de f(t) tempo continuo com fs = 0.6*f0','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);

subplot(2,2,4)   
stem(t_60,amostragem_60,'r','LineWidth',3)             %funcao discretizada no tempo
grid on
title('Grafico de f[n] tempo discreto com fs = 0.6*f0','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);

figure(3)
subplot(2,1,1)   
plot(t_40,amostragem_ang_40,'k','LineWidth',3)         %funcao continua no tempo
grid on
title('Grafico da f(t) tempo discreto com fs = 0.4*f0 e deslocamento de angulo','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);

subplot(2,1,2)   
stem(t_40,amostragem_ang_40,'r','LineWidth',3)         %funcao discretizada no tempo
grid on
title('Grafico da f[n] tempo discreto com fs = 0.4*f0 e deslocamento de angulo','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);
endif
%===============================================================================                 
%grafico em tempo discreto
%3. Exibindo os resultados para alguns valores de fs>f0. (Sugest�o: fs=2f0; fs=20f0)
if (fs>f0)
figure(4)
subplot(2,2,1)   
plot(t_2f0,amostragem_2_f0,'k','LineWidth',3)             %funcao continua no tempo
grid on
title('Grafico de f(t) tempo continuo com fs = 2*f0','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);

subplot(2,2,3)   
stem(t_2f0,amostragem_2_f0,'m','LineWidth',3)             %funcao discretizada no tempo
grid on
title('Grafico de f[n] tempo discreto com fs = 2*f0','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);

subplot(2,2,2)   
plot(t_20f0,amostragem_20_f0,'k','LineWidth',3)             %funcao continua no tempo
grid on
title('Grafico de f(t) tempo continuo com fs = 20*f0 ','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);

subplot(2,2,4)   
stem(t_20f0,amostragem_20_f0,'m','LineWidth',3)             %funcao discretizada no tempo
grid on
title('Grafico de f[n] tempo discreto com fs = 20*f0','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);
%===============================================================================                 
%4. Exibindo os resultados para alguns valores de fs>f0, por�m com varia��o do �ngulo de in�cio da amostragem.
figure(5)
subplot(2,1,1)   
plot(t_20f0,amostragem_ang_20f0,'g','LineWidth',3)         %funcao continua no tempo
grid on
title('Grafico da f(t) tempo discreto com variacao de angulo de fase fs = 20*f0','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('f(t)', 'FontName','Times','FontSize',18);

subplot(2,1,2)   
stem(t_20f0,amostragem_ang_20f0,'b','LineWidth',3)         %funcao discretizada no tempo
grid on
title('Grafico da f[n] tempo discreto com variacao de angulo de fase com fs = 20*f0','FontName','Times','FontSize',22);
xlabel('tempo[n]', 'FontName','Times','FontSize',18);
ylabel('f[n]', 'FontName','Times','FontSize',18);
endif
%===============================================================================                                  