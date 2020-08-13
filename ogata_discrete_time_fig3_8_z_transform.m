%CONTROLE II
%GRAFICO FIG 3-8 - OGATA DISCRETE TIME
%AUTORA: SYLVIELLY S. SOUSA
%PROF.: LUIZ DANIEL 
%CAPÍTULO 3: ANÁLISE NO PLANO 'Z' DE SISTEMAS DE CONTROLE DISCRETOS  
close all
clear all 
clc

%------ OBTENDO A TRANSFORMADA Z PELO MÉTODO DA INTEGRAL DE CONVOLUCAO ------
%FUNCAO DE TRANSFERENCIA :  1/(1 - e^(-(T*(t - p))))
%================= PARAMETROS =================%
Mp = 0.05;                      %maximo sobressinal [%Mp]
tr = 0.9;                       %tempo de subida [s]
%================= OBTENCAO ksi, wn, sigma, wd =================%
c = log(Mp)^2;           
ksi = sqrt(c/(pi^2+c)); 
wn = 1.8/tr;
sigma= ksi*wn;
wd= wn * sqrt(1-ksi^2);
%================= EQUACIONAMENTO =================%
p3 = 10*sigma;                  %polo adicional em p3 10x mais lento
fz = 10*sigma;
fk = 100/100;
p = 2*ksi*wn+p3;
k = fk*((2*ksi*wn*p3)+wn^2)/10;
z = fz*(p3*wn^2)/(10*k);

numpts=100;                     %numero de pontos
%================= CALCULO FTMF =================%
for z1 = 0:z
    %K*(s+z)/(s+p)
    bc = k*[1 z*z1/numpts];   
    ac = [1 p];  
    
    %10/s^2
    bg = 10;
    ag = [1 0 0];

numFTMF = conv(bc,bg);
denFTMF = conv(ac,ag)+ [0 0 conv(bc,bg)];
%================= CRIACAO DE VETOR COM POLOS E ZEROS FTMF =================%
    vctzerosFTMF = roots(numFTMF);
    vctpolosFTMF = roots(denFTMF);
%================= GRAFICO LUGAR GEOMETRICO DAS RAIZES =================%    
plot(real(vctpolosFTMF), imag(vctpolosFTMF),'x');
hold on;
plot(real(vctzerosFTMF), imag(vctzerosFTMF),'o');
end