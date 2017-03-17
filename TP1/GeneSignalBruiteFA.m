function [ts, s, t, x] = GeneSignalBruiteFA (sigma,tau)
% function [ts, s, t, x] = GeneSignalBruiteFA (sigma,tau)
% Génération d'un signal comportant une forme d'onde répétée (5 fois). La forme d'onde est composée d'un niveau haut (à 1)
% suivi d'un biveau bas (à -0.5). Le signal entre 2 formes d'onde est de niveau 0 sur une durée T1. Le signal généré est 
% ensuite bruité avec un bruit gaussien additif centré d'écat-type "sigma".
% Fonction créée pour les besoins du TP sur le filtrage adapté
% Paramètres d'entrée :
%   - sigma : écart-type du bruit à superposer au signal (par défaut sigma=0.1)
%   - tau   : rapport cyclique (valeur entière >= 50) en % de la durée To de la forme d'onde. tau=100*"Nuveau haut"/To. Par défaut tau=75.
%             Si on donne tau < 50 alors il est forcé à 50.
% Paramètres de sortie :
%   - ts    : base de temps de la forme d'onde
%   - s     : forme d'onde
%   - t     : base de temps du signal (bruité) généré
%   - x     : signal généré. x(t) est un signal périodique de période To+T1 bruité
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
  T1=round(0.5*(3500+2000*randn)) ;  % Durée entre 2 formes d'onde
  if T1 > 4000
    T1=4000-T1 ;
  elseif T1<500
    T1=T1+500 ;
  end
  T1  % vérité terrain de la valeur aléatoire à retrouver en analysant le résultat du filtre adapté
  
  s=xo ;  % Forme d'onde
  ts=(0:length(s)-1)*Te ;
  xo=[xo zeros(1,T1)];
  x=xo ;
  for k=1:nbPER-1 % Génération du signal périodique non bruite
    x=[x xo(2:end)];
  end
  x=x+sigma*randn(size(x)) ;  % Ajout du bruit à x(t)
  t=(0:length(x)-1)*Te ; 
end
