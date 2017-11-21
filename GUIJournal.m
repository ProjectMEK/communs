%
% ***GUI POUR L'AFFICHAGE DU JOURNAL***
%    MEK: août 2017
%
% Adapté pour Octave/Matlab
%
function fig = GUIJournal(Ppa)
    flarge =800; fhaut =300;
    lapos =[10 25 flarge fhaut];
    fig  =figure('Name','Journal de bord','tag', 'LeCrieur',...
                 'Resize','on', 'Position', lapos, ...
                 'CloseRequestFcn',{@quienllama,'terminus'},'MenuBar','none',...
                 'defaultuicontrolunits','Normalized',...
                 'DefaultUIControlBackgroundColor',[0.8 0.8 0.8],...
                 'defaultUIControlFontSize',10);
    setappdata(fig,'Ppa',Ppa);
    posx=0.025; posy=0.2; large=1-2*posx; haut=0.95-posy;
    uicontrol('Parent',fig, 'tag','Editorial', 'BackgroundColor',[1 1 1], ...
              'Style','listbox', 'Position',[posx posy large haut], ...
              'String',Ppa.lesmots, 'Value',1);
    haut=0.075; posy=posy-2*haut; large=0.15; dx=0.1; posx=(1-dx-2*large)/2;
    uicontrol('Parent',fig, 'callback',{@quienllama,'reset'}, ...
              'Position',[posx posy large haut], 'String','Mise à zéro');
    posx=posx+large+dx;
    uicontrol('Parent',fig, 'callback',{@quienllama,'sauve'}, 'Position',[posx posy large haut],...
              'String','Sauvegarde', 'tooltipstring','Sauvegarder la journalisation');
end


%
% on call la method "Ppa.(autre)"
%
function quienllama(src,evt, autre)
  Ppa =getappdata(gcf,'Ppa');
  switch autre
  case 'terminus'
    % On efface pas le GUI, on le met invisible.
    % l'Objet qui le gère va s'occuper de l'effacer en temps et lieu.
    set(gcf, 'visible','off');
  case 'reset'
    Ppa.reset(src);
  case 'sauve'
    Ppa.sauve();
  end
end
