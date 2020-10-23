% Exemplo de projeto de malha fechada com PI discreto

clc; clear all; close all;
%K = 0.5; a = 1;
%Ts = 0.1;

K = 1;
Ts = 1e-3;
R = 1e3; C = 10e-6;
a = R*C;

%Gs = tf([K],[1 a]);
Gs = tf(K, [a 1])
GzZOH = c2d(Gs, Ts, 'zoh');
set(GzZOH, 'Variable', 'z^-1')
GzZOH
% GzZOH instável
%b1 = 0.04;
%numZ = [0 b1];
%a1 = -1.3;
%denZ = [1 a1]
%GzZOH = tf(numZ,denZ, Ts);
%set(GzZOH, 'Variable', 'z^-1')
%GzZOH
%pzmap(GzZOH)
% step(GzZOH)

% GzBILIN = c2d(Gs, Ts, 'tustin')

step(Gs)
figure;
step(Gs, GzZOH)
%Extrai o parâmetros da planta
numGz=get(GzZOH,'num'); numGz=numGz{1};
denGz=get(GzZOH,'den'); denGz=denGz{1};
%Estabelecido os parâmetros dinâmicos desejados
% de segunda ordem.
nKsi = 0.6;
w0 = 2*pi*11.93;
k0 = w0*w0;
sys = tf([0 0 k0],[1 2*nKsi*w0 w0*w0]);
step(sys);
GsysZOH = c2d(sys, Ts, 'zoh');
set(GsysZOH, 'Variable', 'z^-1')
['Planta GsysZOH']
GsysZOH

numGsys=get(GsysZOH,'num'); numGsys=numGsys{1};
denGsys=get(GsysZOH,'den'); denGsys=denGsys{1};

% Calculo dos Coeficientes do PI
p1 = denGsys(2); p2 = denGsys(3);
b1 = numGz(2); a1 = denGz(2);
r1 = (p2+a1)/b1; r0 = (p1-a1+1)/b1;
K = -r1; Ti = -Ts*r1/(r1+r0);

numPI = [r0 r1];
denPI = [1 -1];
Gpi_disc = tf(numPI, denPI, Ts);
set(Gpi_disc, 'Variable', 'z^-1')
['FTMF PI convencional']
FTMF = feedback(GzZOH*Gpi_disc, 1)
figure;

%pzmap(GsysZOH,'r',FTMF,'b');
pzmap(FTMF,'r',GsysZOH,'b');

numFTMF=get(FTMF,'num'); numFTMF=numFTMF{1};
denFTMF=get(FTMF,'den'); denFTMF=denFTMF{1};

['Zeros FTMF: ' num2str(roots(numFTMF)) ]
['Zeros Gsys: ' num2str(roots(numGsys)) ]

['Polos FTMF: ' ] 
[ num2str(roots(denFTMF)) ]
['Polos Gsys: ' ] 
[ num2str(roots(denGsys)) ]


% Novo PI, R ~ T
Gpi_disc_S = tf([0 1], denPI, Ts);
Gpi_disc_R = tf(numPI,1,Ts);
% Gpi_disc_T = 1;
% Com a compensação de T:
Gpi_disc_T = r0 + r1;
% Gpi_disc_T = 1;
['FTMF PI - RST, R ~ T']
FTMF2 = Gpi_disc_T*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R)
figure;
step(FTMF2);

%step(GsysZOH,FTMF);
[x,t]=step(GsysZOH);
stairs(t,x, 'g');
hold on
[x,t]=step(FTMF);
stairs(t,x, 'r');
[x,t]=step(FTMF2);
stairs(t,x, 'b');
legend({'GsysZOH (desejado)','FTMF (PI convencional)', 'FTMF2 (PI-RST)'})
% stairs(t, ones(t),'-');
grid on;
hold off
%figure;
%pzmap(FTMF2);

% Hol = GzZOH * Gpi_disc_S * Gpi_disc_R
% FTMF = feedback (Hol, 1) % É equivalente a Gpi_disc_R*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R)
% B/(AS+BR) = feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) 
% 1/GzZOH = A/B
% 1/Gpi_disc_S = S
% Syr = BT/(AS+BR) = Gpi_disc_T*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) 
% Syp = AS/(AS+BR) = (1/GzZOH)*(1/Gpi_disc_S)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) 
% Sup = -AR/(AS+BR) = -(1/GzZOH)*(Gpi_disc_R)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) 
% Syb = -BR/(AS+BR) = -(Gpi_disc_R)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) 
% Syv = BS/(AS+BR) = (1/Gpi_disc_S)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) 
Syv = (1/Gpi_disc_S)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R);
Syp = (1/GzZOH)*(1/Gpi_disc_S)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) ;
Sup = -(1/GzZOH)*(Gpi_disc_R)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) ;
Syb = -(Gpi_disc_R)*feedback(GzZOH*Gpi_disc_S, Gpi_disc_R) ;

figure;
bode(Syb), legend('Syb');
figure;
step(Syb);
figure;
bode(Syv, Syp, Sup, Syb); legend('Syv', 'Syp', 'Sup', 'Syb')
grid on;
%step(Syp);
figure;

FTMA1 = GzZOH * Gpi_disc_S * Gpi_disc_R * 1;
FTMA2 = GzZOH * Gpi_disc_S * Gpi_disc_R * 3;
nyquist(FTMA1, FTMA2);
axis_mod = 3;
axis([-axis_mod axis_mod -axis_mod axis_mod]);      % AXIS([XMIN XMAX YMIN YMAX])
grid;
%figure;
%bode(GzZOH * Gpi_disc_S * Gpi_disc_R);
%figure;
%bode(GzZOH)
