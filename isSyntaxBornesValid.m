%
% isSyntaxBornesValid(t)
%
%  Fonction pour valider les cha�nes de caract�res utiliser pour
%  d�finir des points ou des temps en secondes. �a peut m�me
%  �tre une expression du genre 'P3+2'
%
%     param: t    'String' repr�sentant des points ou valeurs temporelles
%
%     on va avoir besoin de la fonction isSyntaxBorneValid(t)
%
function resultat = isSyntaxBornesValid(t)
  resultat =false;
  pat ='\s+';
  iss =regexp(t, pat, 'split');
  nbParam =length(iss);
  for u =1:nbParam
    resultat =isSyntaxBorneValid(iss{u});
    if ~resultat
      disp(['Mauvais param�tre: ' iss{u}]);
      break;
    end
  end
end
