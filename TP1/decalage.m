%  function y=decalage(x,k0)
%  G�n�re un d�calage de k0 �chantillons.
%  la s�quence d'entr�e x est d�cal�e de k0 �chantillons pour donner la s�quence de
%  sortie y.
%  k0 doit �tre un entier positif.
function y=decalage(x,k0)
  if k0 < 0
    error('	La valeur de k0 doit �tre positive ou nulle!') ;
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
