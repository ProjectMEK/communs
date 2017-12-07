%
% uitable_OCT(varargin)
%
% Fonction pour palier au manque par rapport � Matlab --> uitable()
%
% En entr�e on devra avoir des "paires" {propri�t�,valeur}, ex. 'tag','ma_UItable'
%
%	On va donc se servir d'un uipanel comme "cadre" et les cellules de la uitable
% seront des "uicontrol('style','text' ou 'edit')
%
function varargout = uitable_OCT(varargin)
  % on fabrique une structure contenant les propri�t�s permises
  S.parent =gcf;
  S.position =[0 0 10 10];
  S.tag ='MaUITable';
  S.fontsize =10;
  S.fontname ='FixedWidth';
  S.userdata =0;
  S.columneditable =true;
  S.columnname ={'1'};
  S.columnwidth =0;
  S.rowname ={'1'};
  S.backgroundcolor =[1 1 1];
  S.data =0;
  % maintenant on va peupler cette structure avec le contenu de varargin
  for U =1:2:nargin
    champ =lower(varargin{U});
    % la 2i�me condition nous assure que la propri�t� pourra �tre pair� avec une valeur
    if isfield(S,champ) & nargin > U
    	S.(champ) =varargin{U+1};
    end
  end
  % calcul des dimensions de la uitable en fonction du 'data'
  S.nrow =size(S.data,1);
  S.ncol =size(S.data,2);
  % fabrication du cadre
  ppa =uipanel('parent',S.parent,'position',S.position,'tag',S.tag,'title','','BorderType','beveledin');

end
