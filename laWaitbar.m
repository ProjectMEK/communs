%
% Cr�ation d'une WAITBAR, avec la possibilit� de la positionner
% relativement � une figure. Si aucune figure n'existe alors se
% sera relativement � la position du curseur.
%
% Fonction laWaitbar
% Cr�ateur: MEK, septembre 2011
%
% VARARGIN
% 1- Valeur � afficher
% 2- texte � afficher
% 3- position horizontale(G,gauche,L,left,C,centre,center,D,droit,R,right)
% 4- position verticale(T,top,H,haut,B,bas,bottom,C,centre,center)
% 5- Handle de la figure de r�f�rence
%
function varargout =laWaitbar(varargin)

  % On commence par initialiser les variables au cas ou
  % elles ne seraient pas dans "varargin"
  Val =0;
  texto ='Test de waitbar';
  pHor ='C';
  pVer ='C';

  % Pour le handle de la figure de r�f�rence,
  % il faut savoir que une waitbar est une figure.
  try
    % Octave ne prend pas obligatoirement un ensemble dans lequel chercher
    lesFig =findall('Type','figure');
    lesFigWb =findall('Type','figure', 'tag','waitbar');         % Pour Octave, le tag --> 'waitbar'
  catch Moo;
    lesFig =findall(0, 'Type','figure');
    lesFigWb =findall(0, 'Type','figure', 'tag','TMWWaitbar');   % Pour Matlab, le tag --> 'TMWWaitbar'
  end

  if isempty(lesFig)
    % Si aucune figure n'existe
    hdl =[];
  elseif length(lesFigWb) == length(lesFig)
    % si les figure sont des waitbar
    hdl =[];
  else
    hdl =gcf;
  end

  if nargin == 5
  	hdl =varargin{5};
  end
  if nargin >= 4
  	pVer =lower(varargin{4});
  end
  if nargin >= 3
  	pHor =lower(varargin{3});
  end
  if nargin >= 2
  	texto =varargin{2};
  end
  if nargin >= 1
  	Val =varargin{1};
  end
  Wb =waitbar(Val, texto, 'visible','off');
  set(Wb, 'Units','pixels');
  lapos =get(Wb, 'position');
  if isempty(hdl)
    lapos(:) =round(positioncur(pHor, pVer, lapos(3), lapos(4)));
  else
    lapos(:) =round(positionfen(pHor, pVer, lapos(3), lapos(4), hdl));
  end
  set(Wb, 'position',lapos, 'visible','on');
  figure(Wb);
  if nargout
    varargout{1} =Wb;
  end
end
