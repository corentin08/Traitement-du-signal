function [tc,Cxy] = correl(tx,x,ty,y)
%	function [tc Cxy] = correl(tx,x,ty,y)
%	Calcul de la fonction d'intercorrélation, conformément
%	aux notations du cours de traitement du signal en GE-INSA-RENNES.
%	Paramètres d'entrée
%	  - x  : signal x(t)
%	  - y  : signal y(t) à corréler avec x(t)
%	  - tx : base de temps pour le signal x
%	  - ty : base de temps pour le signal y
%	Paramètres de sortie
%	  - tc  : base de temps pour l'intercorrélation Cxy.
%	  - Cxy : intercorrélation x par y
%
%	Si l'on ne demande pas les resultats de sortie, la fonction
%	affiche les signaux x et y en fonction de leur base de temps
%	ainsi que les fonctions d'intercorrélation Cxy et Cyx en 
%	fonction de sa base de temps.
%	
%
%  	Date de création :
%		13/05/1998
%  	Date de création :
%		30/06/1999
%  	Auteur :
%		K. KPALMA  (pour les TP 3GE)
%
Nx = length(x) ;
Ny = length(y) ;
Te = tx(2)-tx(1) ;	% Il est impératif que les deux signaux soient
				% échantillonnés avec la même période
yy=y(Ny:-1:1);		% Pour compenser le retournement effectuer par CONV
Cxy=Te*conv(x,yy);
tc=tx(1)-ty(Ny)+Te*(0:length(Cxy)-1);

if nargout == 0
  figure
  a=min([tx ty tc]);
  b=max([tx ty tc]);
  c=min([x y Cxy]);
  d=max([x y Cxy]) ;
  subplot(221);plot(tx,x); ylabel('x'); xlabel('t') ;
  I = max([x y Cxy])-min([x y Cxy]) ;
  I = I+I/10 ;
  J = max(tc)-min(tc) ;
  J = min(tc)+J/2; %+J/2 ;
  text(J ,I,'Calcul de fonctions d''intercorrélation') ;
  subplot(222);plot(ty,y); ylabel('y'); xlabel('t') ;
  subplot(223);plot(tc,Cxy); ylabel('Cxy'); xlabel('t') ;
  
  xx=x(Nx:-1:1);	% Pour compenser le retournement effectuer par CONV
  Cxy=Te*conv(y,xx);
  tc=ty(1)-tx(Nx)+Te+Te*(0:length(Cxy)-1);
  Axes = [min([a tx ty tc]) max([b tx ty tc]) min([c x y Cxy]) max([d x y Cxy])] ;
  subplot(224);plot(tc,Cxy); ylabel('Cyx'); xlabel('t') ; axis(Axes) ;
  subplot(221); axis(Axes) ;
  subplot(222); axis(Axes) ;
  subplot(223); axis(Axes) ;
end ;