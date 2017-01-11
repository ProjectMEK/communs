%
% Ici on check si la position 'lapos' peut fitter dans le moniteur
% en fonction d'un point de référence 'fenref' donné par le coin
% bas-gauche
% On retourne une position corrigé si nécesaire.
%
function V =CaFitTi(fenref, lapos)
  V =lapos;
  Laref =max(1, fenref(1));
  monpos =get(0,'MonitorPositions');
  % on recherche dans quel moniteur on affiche
  for U =1:size(monpos, 1)
    if (Laref >= monpos(U, 1)) && (Laref <= monpos(U, 3))
      % plus grand que la position gauche d'un moniteur et
      % plus petit que la position à droite de ce moniteur
      V(1) =min(max(monpos(U, 1), V(1)), monpos(U, 3)-V(3));
      % on tient aussi compte de la bordure du haut de la fenêtre (25)
      V(2) =min(max(1, V(2)), monpos(U, 4)-monpos(U, 2)+1-V(4)-25);
    end
  end
end
