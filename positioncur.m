%
% Fonction positioncur
% Créateur: MEK, janvier 2010
%
% VARARGIN
% 1- position horizontale(G,gauche,L,left,C,centre,center,D,droit,R,right)
% 2- position verticale(T,top,H,haut,B,bas,bottom,C,centre,center)
% 3- largeur de la fenêtre
% 4- Hauteur de la fenêtre
%
% retourne une position en fonction du moniteur ou le curseur se trouve.
% si je veux avoir une fenêtre de 300X400 centrée en hauteur à gauche
%    pos = positioncur('G', 'C', 300, 400)
%
function varargout =positioncur(varargin)
  % position du curseur
  fenpos =get(0,'pointerlocation');
  % position du moniteur courant
  pp =monitcur();
  if nargin >= 4
  	horiz =lower(varargin{1});
  	verti =lower(varargin{2});
  	large =varargin{3};
  	haute =varargin{4};
  elseif nargin >= 2
  	horiz =lower(varargin{1});
  	verti =lower(varargin{2});
  	large =pp(3)/3;
  	haute =pp(4)/3;
  else
  	horiz ='centre';
  	verti ='centre';
  	large =pp(3)/3;
  	haute =pp(4)/3;
  end
  final =[0 0 large haute];

  switch horiz
  %------------
  case {'left','gauche','g','l'}
  	final(1) =fenpos(1)-large;
  %------------
  case {'right','droit','r','d'}
  	final(1) =fenpos(1);
  %------------
  case {'center','centre','c'}
  	final(1) =round(fenpos(1)-large/2);
  end
  switch verti
  %------------
  case {'top','haut','t','h'}
  	final(2) =fenpos(2);
  %------------
  case {'bottom','bas','b'}
  	final(2) =fenpos(2)-haute;
  %------------
  case {'center','centre','c'}
  	final(2) =round(fenpos(2)-haute/2);
  end
  final(1) =min(max(final(1),pp(1)+20), pp(1)+pp(3)-final(3));
  final(2) =min(max(final(2),pp(2)+20), pp(2)+pp(4)-final(4));
  varargout{1} =final;
return
  