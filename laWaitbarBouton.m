%
% Cr�ation d'une WAITBAR augment� d'un bouton, avec la possibilit�
% de la positionner relativement � une figure. Si aucune figure n'existe
% alors se sera relativement � la position du curseur. De plus, sa propri�t�
% 'WindowStyle' sera 'modal'.
%
% Cr�ateur: MEK, septembre 2011
%
% VARARGIN
% 1- Valeur � afficher
% 2- texte � afficher
% 3- position horizontale(G,gauche,L,left,C,centre,center,D,droit,R,right)
% 4- position verticale(T,top,H,haut,B,bas,bottom,C,centre,center)
% 5- Handle de la r�f�rence
% 6- tag du bouton
%
function varargout =laWaitbarBouton(varargin)
  % On va cr�er un objet "laWaitbar"
  if nargin == 6
    Wb =laWaitbar(varargin{1:5});
    letag =varargin{6};
  else
    Wb =laWaitbar(varargin{:});
    letag ='TagLaWaitbarBouton';
  end
  %_____________________________________________
  % On va l'augmenter d'un bouton et le rendre modal
  lapos =get(Wb, 'position');
  step =50;
  lapos(4) =lapos(4)+step;
  set(Wb, 'position',lapos);
  foo =get(Wb, 'Children');
  set(foo, 'Units','pixels');
  posfoo =get(foo, 'Position');
  posfoo(2) =lapos(4)-posfoo(4)-step+5;
  set(foo, 'Position', posfoo);
  large =80; haut =22; posy =20; posx =round((lapos(3)-large)/2);
  uicontrol('Parent',Wb, 'Tag',letag, 'String','Arr�t', 'Position',[posx posy large haut]);
  set(Wb, 'WindowStyle','modal');
  figure(Wb);
  if nargout
    varargout{1} =Wb;
  end

end
