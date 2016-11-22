%
% isSyntaxBornesValid(t)
%
%  Fonction pour valider les chaînes de caractères utiliser pour
%  définir des points ou des temps en secondes. Ça peut même
%  être une expression du genre 'P3+2'
%
%     param: t    'String' représentant des points ou valeurs temporelles
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
      disp(['Mauvais paramètre: ' iss{u}]);
      break;
    end
  end
end
