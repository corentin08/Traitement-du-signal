function [tc,Cxy] = convol(tx,x,ty,y)
%	function [tc Cxy] = convol(tx,x,ty,y)
%	Calcul du produit de convolution de deux signaux, conformément
%	aux notations du cours de traitement du signal en GE-INSA-RENNES.
%	Paramètres d'entrée
%	  - x  : signal x(t)
%	  - y  : signal y(t) à corréler avec x(t)
%	  - tx : base de temps pour le signal x
%	  - ty : base de temps pour le signal y
%	Paramètres de sortie
%	  - tc  : base de temps pour l'intercorrélation Cxy.
%	  - Cxy : produit de convolution de x et y
%
%	Si l'on ne demande pas les resultats de sortie, la fonction
%	affiche les signaux x et y en fonction de leur base de temps
%	ainsi que le produit de convolution en fonction de sa base de temps.
%	
%
%  	Date de création :
%		14/05/1998
%  	Date de modification :
%		30/06/1999
%  	Auteur :
%		K. KPALMA  (pour les TP 3GE)
%
Nx = length(x) ;
Ny = length(y) ;
Te = tx(2)-tx(1) ;	% Il est impératif que les deux signaux soient
				% échantillonnés avec la même période
Cxy=Te*conv(x,y);
tc=tx(1)+ty(1)+Te*(0:length(Cxy)-1);
Axes = [min([tx ty tc]) max([tx ty tc]) min([x y Cxy]) max([x y Cxy])] ;
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
  J = min(tc)+J/2;
  text(J ,I,'Calcul de produits de convolution') ;
  subplot(222);plot(ty,y); ylabel('y'); xlabel('t') ;
  subplot(223);plot(tc,Cxy); ylabel('x*y'); xlabel('t') ;
  
  Cxy=Te*conv(y,x);
  Axes = [min([a tx ty tc]) max([b tx ty tc]) min([c x y Cxy]) max([d x y Cxy])] ;
  subplot(224);plot(tc,Cxy); ylabel('y*x'); xlabel('t') ; axis(Axes) ;
  subplot(221); axis(Axes) ;
  subplot(222); axis(Axes) ;
  subplot(223); axis(Axes) ;
end ;