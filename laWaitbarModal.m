%
% Cr�ation d'une WAITBAR, avec la possibilit� de la positionner
% relativement � une figure. Si aucune figure n'existe alors se
% sera relativement � la position du curseur. De plus, sa propri�t�
% 'WindowStyle' sera 'modal'.
%
% Fonction laWaitbarModal
% Cr�ateur: MEK, avril 2015
%
% VARARGIN
% 1- Valeur � afficher
% 2- texte � afficher
% 3- position horizontale(G,gauche,L,left,C,centre,center,D,droit,R,right)
% 4- position verticale(T,top,H,haut,B,bas,bottom,C,centre,center)
% 5- Handle de la r�f�rence
%
function varargout =laWaitbarModal(varargin)

  %On va cr�er un objet "laWaitbar"
  foo =laWaitbar(varargin{:});

  %on va le rendre "modal"
  set(foo, 'WindowStyle','modal');

  if nargout
    varargout{1} =foo;
  end
end
