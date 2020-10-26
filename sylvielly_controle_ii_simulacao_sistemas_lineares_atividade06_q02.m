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
disp("                           MODELO ARX                                ")                                                                  
disp("                   SIMULACAO DE SISTEMAS LINEARES                       ")                        
disp("========================================================================")

%codigo prof. Aguirre
%===============================================================================
%                                   DADOS  
%===============================================================================
%coeficientes do polinomio A
a_1 = 1.5;
a_2 = -0.7;
%coeficientes do polinomio B
b_1 = 1;
b_2 = 0.5;
%atrasos
at_1 = 1;
at_2 = 3;
at_3 = 5;
%===============================================================================
%                                 CALCULOS  
%===============================================================================
%degrau atrasado em 10, ou seja. Quando a posicao do vetor for = 10, o sistema
%"parte" com o degrau 





u=[zeros(10,1);ones(40,1)];        %10 posicoes com valor = 0 e 40 posicoes com valor = 1
y=zeros(size(u));                  %vetor de zeros ate o tamanho do vetor 'u'

%atraso de '1'
for k = (at_3+2):length(u)
  y(k) = a_1*y(k-1) + a_2*y(k-2) + b_1*u(k-at_1) + b_2*u(k-(at_1+1));
endfor

y_1=y;                             %saida y_1
y=zeros(size(u));                  %vetor de zeros ate o tamanho do vetor 'u'

%atraso de '3'
for k = (at_3+2):length(u)
  y(k) = a_1*y(k-1) + a_2*y(k-2) + b_1*u(k-at_2) + b_2*u(k-(at_2+1));
endfor

y_2 = y;                           %saida y_2
y=zeros(size(u));                  %vetor de zeros ate o tamanho do vetor 'u'

%atraso de '5'
for k = (at_3+2):length(u)
  y(k) = a_1*y(k-1) + a_2*y(k-2) + b_1*u(k-at_3) + b_2*u(k-(at_3+1));
endfor

y_3 = y;                           %saida y_3

figure(1)
plot(y_1,"or;y_1: com atraso puro = 1;",'LineWidth',3,y_2,"*b;y_2: com atraso puro = 3;",'LineWidth',6,y_3,"pg;y_3: com atraso puro = 5;",'LineWidth',6)
title('Modelo ARX : Ordem, Atraso Puro de Tempo e Ganho','FontName','Times','FontSize',20);
xlabel('tempo(t)', 'FontName','Times','FontSize',16);
ylabel('y_k', 'FontName','Times','FontSize',16);
