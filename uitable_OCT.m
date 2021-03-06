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
% Dans la propri�t� "userdata" du uipanel, nous allons conserver la structure des
% infos utiles � la gestion future.
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
  S.rowname ={'1'};
  S.columnname ={'1'};
  S.columnwidth =0;
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
  % Nom des colonnes
  if length(S.columnname) ~= S.ncol
    S.columnname ={};
    for U =1:S.ncol
      S.columnname{end+1} =num2str(U);
    end
  end
  % Nom des rang�es
  if length(S.rowname) ~= S.nrow
    S.rowname ={};
    for U =1:S.nrow
      S.rowname{end+1} =num2str(U);
    end
  end
  % format d'affichage
  if length(S.userdata) ~= S.ncol
    S.userdata ={};
    for U =1:S.ncol
      S.userdata{end+1} ='%9.3f';
    end
  end
  % fabrication du cadre
  ppa =uipanel('parent',S.parent,'units','pixels','position',S.position,'tag',S.tag,'title','',...
               'BorderType','beveledin','userdata',S);
  % calcul des dimensions des cellules
  lpan =S.position(3);
  largs =round(lpan/(S.ncol+0.5));
  larg1 =lpan-largs*S.ncol;
  % fabrication des cellules pour afficher les datas
  A =CAideGUI();
  A.posx=0;A.haut=min(22,round(S.position(4)/(S.nrow+1)));A.large=larg1;posy=S.position(4)-A.haut;A.posy=posy;
  % colonne des titres des rang�es
  uicontrol('parent',ppa,'units','pixels','position',A.pos,'style','text');
  for U=1:S.nrow
    A.posy =A.posy-A.haut;
    uicontrol('parent',ppa,'units','pixels','position',A.pos,'style','text',...
              'string',S.rowname{U},'horizontalalignment','center');
  end
  % chacune des colonnes de datas
  for C=1:S.ncol
    % on remonte en haut et on tasse de 1 vers la droite
    A.posy=posy;A.posx=A.posx+A.large;A.large=largs;
    % titre de la colonne
    uicontrol('parent',ppa,'units','pixels','position',A.pos,'style','text',...
              'string',S.columnname{C},'horizontalalignment','center');
    for U=1:S.nrow
      A.posy =A.posy-A.haut;
      uicontrol('parent',ppa,'units','pixels','position',A.pos,'style','edit','string',S.data{U,C},...
                'userdata',[U C],'backgroundcolor',S.backgroundcolor,'callback',@editCell);
    end
  end
end

%----------------------------------------------------------------
% Pour simuler le comportement de la propri�t� 'CellEditCallback'
%----------------------------------------------------------------
function editCell(src,varargin)
  % lecture des infos utiles du uipanel
  Ppa =get(src,'parent');
  S =get(Ppa,'userdata');
  % lecture de la position "index"
  indx =get(src,'userdata');
  % v�rification de la nouvelle valeur entr�e
  Vnum =str2num(get(src,'string'));
  if isempty(Vnum)
    Vnum =str2num(S.data{indx(1),indx(2)});
  end
  % on affiche en fonction du format demand�
  Vtxt =sprintf(S.userdata{indx(2)}, Vnum);
  set(src,'string',Vtxt);
  % on sauvegarde pour le futur
  S.data{indx(1),indx(2)} =Vtxt;
  set(Ppa,'userdata',S);
end
