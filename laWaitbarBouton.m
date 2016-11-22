%
% Création d'une WAITBAR augmenté d'un bouton, avec la possibilité
% de la positionner relativement à une figure. Si aucune figure n'existe
% alors se sera relativement à la position du curseur. De plus, sa propriété
% 'WindowStyle' sera 'modal'.
%
% Créateur: MEK, septembre 2011
%
% VARARGIN
% 1- Valeur à afficher
% 2- texte à afficher
% 3- position horizontale(G,gauche,L,left,C,centre,center,D,droit,R,right)
% 4- position verticale(T,top,H,haut,B,bas,bottom,C,centre,center)
% 5- Handle de la référence
% 6- tag du bouton
%
function varargout =laWaitbarBouton(varargin)
  % On va créer un objet "laWaitbar"
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
  uicontrol('Parent',Wb, 'Tag',letag, 'String','Arrêt', 'Position',[posx posy large haut]);
  set(Wb, 'WindowStyle','modal');
  figure(Wb);
  if nargout
    varargout{1} =Wb;
  end

end
