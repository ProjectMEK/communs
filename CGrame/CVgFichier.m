%
% classdef CVgFichier < handle
%
% Variables globales des fichiers format Analyse
%
% METHODS
%           initial(tO, vg)
%       V = databrut(tO)
%   clone = copie(tO)
%
classdef CVgFichier < handle

  properties
    laver =1.0;
    itype =[];        % 1-analyse, 2-texte, 3-a21xml...
    otype =8;         % contient la version matlab � sauvegarder V6 ou V7 ou V7.3
    sauve =false;
    valeur =0;
    nad =1;           % nombre de canaux
    ess =1;           % nombre d'essai
    lesess ={};       % liste nom essai pour afficher
    lescats ={};      % liste nom cat�gorie pour afficher
    nst =0;
    nomstim ={};
    niveau =0;
    affniv =0;
    pt =1;                     % 1- afficher les points marqu�s avec texte, 2- sans texte
    can =1;                    % canal � afficher
    toucan =false;             % afficher tous les canaux
    tri =1;                    % essai � afficher
    toutri =false;             % afficher tous les essais
    cat =1;                    % cat�gorie � afficher
    xy =0;                     % affiche X vs Y plut�t que X vs temps
    x =[];
    y =[];
    zoom =1;
    zoomonoff =1;
    affcoord =CEOnOff(false);  % afficher le DataCursor
    ligne =0;
    colcan =true;              % afficher couleur pour canaux
    coless =false;
    colcat =true;
    legende =false;
    letemps =0;
    defniv =1;
    permute =0;
    choixy =[];
    filtp =0;
    filtpmin =0.0;
    filtpmax =0.1;
    xymarkx =1;
    xymarkxecart =10;
    xymarkyecart =10;
    loq =1;
    xlim =0;
    ylim =0;
    trich =0;
    deroul =[0.0100 0.0500];
    multiaff =[];
    xval =[0 1];
    yval =[0 1];
  end  %properties

  methods

    %-------
    function initial(tO, vg)
      CDefautFncBase.initial(tO, 'CVgFichier', vg);
    end

    %-------
    function V = databrut(tO)
      V =CDefautFncBase.databrut(tO, 'CVgFichier');
    end
    %-------
    function clone = copie(tO)
      clone =CDefautFncBase.copie(tO, 'CVgFichier');
    end

  end  %methods
end
