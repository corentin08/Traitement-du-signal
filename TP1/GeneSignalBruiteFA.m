function [ts, s, t, x] = GeneSignalBruiteFA (sigma,tau)
% function [ts, s, t, x] = GeneSignalBruiteFA (sigma,tau)
% G�n�ration d'un signal comportant une forme d'onde r�p�t�e (5 fois). La forme d'onde est compos�e d'un niveau haut (� 1)
% suivi d'un biveau bas (� -0.5). Le signal entre 2 formes d'onde est de niveau 0 sur une dur�e T1. Le signal g�n�r� est 
% ensuite bruit� avec un bruit gaussien additif centr� d'�cat-type "sigma".
% Fonction cr��e pour les besoins du TP sur le filtrage adapt�
% Param�tres d'entr�e :
%   - sigma : �cart-type du bruit � superposer au signal (par d�faut sigma=0.1)
%   - tau   : rapport cyclique (valeur enti�re >= 50) en % de la dur�e To de la forme d'onde. tau=100*"Nuveau haut"/To. Par d�faut tau=75.
%             Si on donne tau < 50 alors il est forc� � 50.
% Param�tres de sortie :
%   - ts    : base de temps de la forme d'onde
%   - s     : forme d'onde
%   - t     : base de temps du signal (bruit�) g�n�r�
%   - x     : signal g�n�r�. x(t) est un signal p�riodique de p�riode To+T1 bruit�
% Author: K. KPALMA (2016)

  if nargin==0
    sigma=0.1 ; tau=75 ;
  elseif nargin==1
    tau=75 ;
  end
  if tau < 50, tau=50; end
  nbPER=5 ;
  Te=0.001 ;  % Pour avoir 1000 pts sur 1 s
  a=1; b=-0.5;
  tau=round(10*tau) ;
  xo=[0 a*ones(1,tau) b*ones(1,1000-tau) 0] ;
  T1=round(0.5*(3500+2000*randn)) ;  % Dur�e entre 2 formes d'onde
  if T1 > 4000
    T1=4000-T1 ;
  elseif T1<500
    T1=T1+500 ;
  end
  T1  % v�rit� terrain de la valeur al�atoire � retrouver en analysant le r�sultat du filtre adapt�
  
  s=xo ;  % Forme d'onde
  ts=(0:length(s)-1)*Te ;
  xo=[xo zeros(1,T1)];
  x=xo ;
  for k=1:nbPER-1 % G�n�ration du signal p�riodique non bruite
    x=[x xo(2:end)];
  end
  x=x+sigma*randn(size(x)) ;  % Ajout du bruit � x(t)
  t=(0:length(x)-1)*Te ; 
end
