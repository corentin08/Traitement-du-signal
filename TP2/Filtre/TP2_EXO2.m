clear all;
close all ; 
Fe = 200; 	% Fréquence d'échantillonnage
t=0:1/Fe:1;

%------------------------------------------------
% Génération du signal s(t)
%------------------------------------------------
s1=sin(2*pi*t*5);
s2=sin(2*pi*t*15);
s3=sin(2*pi*t*30);
s=s1+s2+s3;
figure(1)
plot(t,s);


%------------------------------------------------
% Définition du gabarit du filtre
%------------------------------------------------
%filtrage 15HZ
%Wp=[10 18]/(Fe/2)
%Ws=[8 20]/(Fe/2)

%filtrage 5Hz
Wp=[4 7]/(Fe/2)
Ws=[3 8]/(Fe/2)

    %------------------
    %BUTTERWORTH
    %------------------
[n, Wn]=buttord(Wp, Ws, 3, 20);
[b,a]=butter(n, Wn);
    %------------------
    %CHEB1
    %------------------
%[n,Wp] = cheb1ord(Wp,Ws,3,20);
%[b,a] = cheby1(n,3,Wp);

%------------------------------------------------
% Calcul et affichage de la réponse 
% fréquentielle du filtre défini
%------------------------------------------------
dirac=zeros(size(t))
dirac(1)=Fe
h=filter(b,a,dirac)
[f,H]=afourier(h,t);
figure(2), plot(f,abs(H))
%------------------------------------------------
% Filtrage
%------------------------------------------------
sf=filter(b,a,s);
figure(4), plot(t,sf, 'b',t, s1,'r'),title('Signal filtré');
%------------------------------------------------
% Calcul des TF de s(t) et de s(t) filtré
%------------------------------------------------
[f,S]=afourier(s,t);
[f,SF]=afourier(sf,t);
%------------------------------------------------
% Visualisation des spectres
%------------------------------------------------
figure(5), plot(f,abs(S),'c', f,abs(SF),'b');
