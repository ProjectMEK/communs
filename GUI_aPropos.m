%
% Affichage de la fenêtre "À propos"
% 
% en entrée on veut une cellule "triple" avec:
% foo = {les phrases à afficher, ...
%        le nombre d'interligne à passer pour l'affichage, ...
%        la FontSize (si zéro --> valeur par défaut)}
% puis la couleur pour le background
% colore = [R G B] ou 0 pour la couleur par défaut
%
% 26 février 2015, MEK
%
function GUI_aPropos(foo, colore)
  epay =20;
  interlig =round(epay/2);
  N =0;
  for U =1:length(foo)
    N =N+foo{U}{2};
  end 
  fenx =250;
  feny =(length(foo)+4)*epay+(N+3)*interlig;
  if ~exist('colore','var') | ~colore
    colore =[0 0.8 0.8];
  end
  % on va centrer ce nouveau GUI horizontalement et verticalement
  % par rapport à la figure courante (gcf).
  lapos =positionfen('C','C',fenx,feny);
  bordx =floor(0.1*fenx);
  largtext =floor(0.8*fenx);
  % fontsize = 9...
  FS9=9; FS7=7;
  %___________________________________________________________________
  % boîte standard, on peut y passer: (position) ou (position,couleur)
  %-------------------------
  labox =fen_aPropos(lapos, colore);
  largeur =largtext; hauteur =epay;
  posx =bordx; posy =feny-epay-(interlig);
  uicontrol('Parent',labox,'style','text','position',[posx posy-hauteur largeur 2*hauteur],...
            'FontWeight','bold', 'string','Avec la collaboration du GRAME');
  for U =1:length(foo)
    posy =posy-hauteur-(interlig*foo{U}{2});
    if foo{U}{3}
      uicontrol('Parent',labox,'style','text','position',[posx posy largeur hauteur],...
                'fontsize',foo{U}{3}, 'string',foo{U}{1});
    else
      uicontrol('Parent',labox,'style','text','position',[posx posy largeur hauteur],...
                'string',foo{U}{1});
    end
  end
  posy =posy-hauteur-2*interlig;
  uicontrol('Parent',labox,'style','text','position',[posx posy largeur hauteur],...
            'fontsize',FS9,'string','Programmeur/Analyste:');
  posy =posy-hauteur;
  uicontrol('Parent',labox,'style','text','position',[posx posy largeur hauteur],...
            'fontsize',FS9,'string','M.E.Kaszap');
  posy =posy-hauteur;
  uicontrol('Parent',labox,'style','text','position',[posx posy largeur hauteur],...
            'fontsize',FS7,'string','courriel: grame@kin.ulaval.ca ');
end

%
% fabrication de la fenêtre "À propos"
% Le Tag par défaut est: 'Tag','APROPOS'
%
% on passe en paramètre
%    (LaPosition) ou bien (LaPosition, LaCouleurDeFond)
%
function a =fen_aPropos(lapos, colo)
  a =dialog('Tag','APROPOS', 'Units','pixels', 'position',lapos,...
            'Name','Rendons à César... ', 'MenuBar','none', ...
            'NumberTitle','off', 'Resize','off', 'Color',colo, 'WindowStyle','normal',...
            'DefaultUIControlBackgroundColor',colo,...
            'DefaultUIControlHorizontalAlignment','center', 'DefaultUIControlFontSize',10);
end
