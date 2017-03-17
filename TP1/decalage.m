%  function y=decalage(x,k0)
%  Génère un décalage de k0 échantillons.
%  la séquence d'entrée x est décalée de k0 échantillons pour donner la séquence de
%  sortie y.
%  k0 doit être un entier positif.
function y=decalage(x,k0)
  if k0 < 0
    error('	La valeur de k0 doit être positive ou nulle!') ;
  end;
  [n m] = size(x) ;
  if n > m
    n = n+k0 ;
  else
    m = m + k0 ;
  end ;
  y = zeros(n,m);
  l = length(x) ;
  y(k0+1:k0+l) = x ;
