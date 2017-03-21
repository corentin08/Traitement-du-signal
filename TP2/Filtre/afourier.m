%  [f X]=afourier(x,t)
%  Simulataion de la transform�e de Fourier analogique
%  � l'aide de la FFT.
%
%  Param�tres d'entr�e :
%	t  : base de temps pour le signal
%	x  : signal d'entr�e x(t)
%  Param�tres de sortie :
%	f  : variable fr�quence
%	FX : transform�e de Fourier de x
%
%  Date de cr�ation :
%		19/02/2004
%  Auteur :
%		K. KPALMA
%  Date de modification : 30 mars 2009
%      Changement de syntaxe [f X]=afourier(x,t) au lieu de [f,FX] = afourier(Fe,x,type).
%      On prend en compte l'information du temps
%      NB : si le nombre de points est trop faible (< 32768) alors on le compl�te par des 0 jq� 32768.
%           pour la normalisation, si le nombre de points non nuls, Lnz, est trop faible face au
%           nombre de points du signal L, on normalise avec Lnz au lieu de L. 
%  Exemple : signal comportant une composante paire et une composante impaire
% Te=0.001;t=-0.5:Te:0.5;x=0.25+cos(2*pi*50*t)+2*sin(2*pi*250*t);[f,X]=afourier(x,t);plot(f,1.25+real(X),'r',f,2.5+imag(X),'g',f,abs(X),'b')

function [f X]=afourier(x,t)
%   N=32768 ;
  Fe=1 ;
  L=length(x) ;
%   if L > N
    N = L ;
%   end
  X=fft(x,N) ;
%   if nnz(x) < 0.5*L	% si le nombre de nnz est trop faible
  absx=abs(x) ; absx=absx/max(absx) ;
  if sum(absx>1e-6) < 0.75*L	% n�gliger les �chantillons inf�rieurs � max/10
    L=sum(absx>1e-6);%nnz(x) ;
  end
%     L=sum(absx>0.01);%nnz(x) ;
%   X=fftshift(X/L) ;
  f=Fe*(-N/2:N/2-1)/N ;		% Variable fr�quence
  if nargin == 2
    Te=t(2)-t(1) ;	% P�riode d'�chantillonnage
    Fe=1/Te ;         % Fr�quence d'�chantillonnage
    f=Fe*(-N/2:N/2-1)/N ;		% Variable fr�quence
    Ret=exp(-2j*pi*f*t(1)) ;	% | Th. du retard : avancer le signal de -t(1) pour compenser le fait que Matlab ne
    X=X.*Ret ;                % | prend pas en compte le temps et consid�re que les �chantillons commencent � n=0. 
  end
  X=fftshift(X) ;
