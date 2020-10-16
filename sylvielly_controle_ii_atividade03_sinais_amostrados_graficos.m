%===============================================================================
%CONTROLE II
%AUTORA: SYLVIELLY S. SOUSA                           %MATRICULA: 20162045070410
%SEMESTRE 2020.1          
%PROF.: LUIZ DANIEL BEZERRA
%ATIVIDADE 03: SINAIS AMOSTRADOSS                     %ENTREGA: 01/09/2020
%===============================================================================

close all
clear all 
clc

%pacotes necessarios para funcionamento
pkg load signal
pkg load control
pkg load symbolic

%Mostre que o circuito abaixo funciona de forma similar a um amostrador de ordem zero
%(sugestão – derive o modelo equivalente na freqüência complexa s do circuito):
 
                         %Ri << Ro
 
%Exiba um exemplo comparativo entre o circuito acima (elaborado no MATLAB ou
%OCTAVE ou PSIM) e um amostrador de ordem zero (sugestão: no PSIM existe um
%bloco chamado ZOH que emula tal efeito, assim como no MATLAB/Simulink).

%Explique a escolha dos valores de Ri, C e Ro. Adote uma freqüência de amostragem
%igual a 100Hz (T=1/100Hz). Utilize como exemplo de sinal e(t) uma senóide cuja
%freqüência é 5Hz.

f_s = 100;
t_max = 2;

%===============================================================================
%                                 CALCULOS  
%===============================================================================
V_m = 1;
f = 5;
T = 1/f_s;                         %periodo de amostragem
t = 0:T:t_max;                     %tempo total analisado
e_t = V_m*sin(2*pi*f*t);           %senoide

%plotando o sinal de entrada
figure(1)
subplot(2,1,1)   
plot(t,e_t,'k','LineWidth',3)         %funcao continua no tempo
grid on
title('Grafico da tensao de entrada e(t)','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('e(t)', 'FontName','Times','FontSize',18);

%chamada da biblioteca 'symbolic' para transformar convoluir o sinal de entrada
%com a funcao de transferencia do zero-order hold
  %rotina para tratamento da senoide 
  syms t;                                  %tratamento de 't' para 's'
  e_t = sym(V_m*sin(2*pi*f*t));            %sistema
  E_s = laplace(e_t);                      %aplica transformada de Laplace no sinal de entrada
  E_s = char(E_s);                         %apos o sistema ser representado em Laplace, transforma a funcao simbolica em string
  s = tf('s');                 
  E_s = eval(['E_s=',E_s]);         %obtencao da FT a partir da string criada da senoide em frequencia
  ZOH = c2d(E_s,T,"impulse");       %c2d [continuous to discrete, insere a senoide em frequencia em ZOH

%faixa de valores de tempo para simulacao
t = 0:T:t_max;                                               
figure(1)
subplot(2,1,2)   
impulse(t,ZOH,'b','LineWidth',4)           %funcao digitalizada
grid on
title('Grafico de ZOH','FontName','Times','FontSize',22);
xlabel('tempo(t)', 'FontName','Times','FontSize',18);
ylabel('ZOH(t)', 'FontName','Times','FontSize',18);
%%
%%
%%
%===============================================================================
%                                 NOTAS  
%===============================================================================
%para o pacote symbolic faz-se necessario baixar a biblioteca para windows 
%'symbolic-win-py-bundle-2.9.0'(Windows)
%link em: <https://github.com/cbm755/octsympy/releases> 
%comandos para instalacao da biblioteca 
%pkg install C:\<seu_diretorio>\symbolic-win-py-bundle-2.9.0.tar.gz
%pkg install C:\<seu_diretorio>\octsympy-2.9.0.tar.gz

