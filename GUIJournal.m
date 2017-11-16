%
% ***GUI POUR L'AFFICHAGE DU JOURNAL***
%    MEK: août 2017
%
function fig = GUIJournal(Ppa)
    flarge =800; fhaut =300;
    lapos =[10 25 flarge fhaut];
    fig  =figure('Name','Journal de bord','tag', 'LeCrieur',...
                 'Resize','on', 'Position', lapos, ...
                 'CloseRequestFcn',@terminus,'MenuBar','none',...
                 'defaultuicontrolunits','Normalized',...
                 'DefaultUIControlBackgroundColor',[0.8 0.8 0.8],...
                 'defaultUIControlFontSize',10, 'userdata',{Ppa});
    posx=0.025; posy=0.2; large=1-2*posx; haut=0.95-posy;
    uicontrol('Parent',fig, 'tag','Editorial', 'BackgroundColor',[1 1 1], ...
              'Style','listbox', 'Position',[posx posy large haut], ...
              'String',Ppa.lesmots, 'Value',1);
    haut=0.075; posy=posy-2*haut; large=0.15; dx=0.1; posx=(1-dx-2*large)/2;
    uicontrol('Parent',fig, 'Callback',@onReset, ...
              'Position',[posx posy large haut], 'String','Mise à zéro');
    posx=posx+large+dx;
    uicontrol('Parent',fig, 'Callback',@onSauve, 'Position',[posx posy large haut],...
              'String','Sauvegarde', 'tooltipstring','Sauvegarder la journalisation');
end

%
% On efface pas le GUI, on le met invisible.
% l'Objet qui le gère va s'occuper de l'effacer en temps et lieu.
%
function terminus(varargin)
  set(gcf, 'visible','off');
end

%
% on call la method "Ppa.reset"
%
function onReset(varargin)
  H =get(gcf,'userdata');
  class(H)
  H.reset();
end

%
% on call la method "Ppa.sauve"
%
function onSauve(varargin)
  Ppa =get(gcf,'userdata');
  Ppa.sauve();
end
