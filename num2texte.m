% Function T = num2texte(X, N)
%          T =  num2texte(X)
%
% transformation de la variable num�rique "X" au format texte
% sur N caract�res o� on comble avec des z�ros par la gauche.
%
% Si N est omis, N =3
%
% Ex:  num2texte(5,2)  --> 05
%      num2texte(5)    --> 005
%______________________________
%
function texte =num2texte(X, N)
  if (nargin < 2) | ~isnumeric(N) | isempty(N) | (N < 1)
    N =3;
  end
  t =['%0' num2str(N) 'd'];
  texte =sprintf(t,X);
end
