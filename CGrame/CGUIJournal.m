%
% classdef CGUIJournal < CParamJournal
%
% Classe de gestion du GUI GUIJournal
% prendra en charge tous les callback du GUI
%
% METHODS
%  tO = CGUIJournal(tO)
%       delete(tO)
%       initGui(tO)
%       initLesmots(tO)
%       afficher(tO, varargin)
%       reset(tO, varargin)
%       ajouter(tO, T)
%       sauve(tO, varargin)
%       sauvegarde(tO, fichnom)
%
%
classdef CGUIJournal < CParamJournal

  methods

    %-----------------------
    % CONSTRUCTOR
    %-----------------------
    function tO = CGUIJournal(tO)
      tO.initGui();
    end

    %------------------------------------------------
    %                    DESTRUCTOR
    % **** NE PAS OUBLIER D'IMPL�MENTER LE DESTRUCTOR
    %      DANS LA CLASSE QUI VA H�RITER DE CELLE-CI
    %------------------------------------------------
    function onDelete(tO)
      if ~isempty(tO.fig)
        delete(tO.fig);
        tO.fig =[];
      end
    end

    %-------------------
    % Cr�ation du GUI
    %-------------------
    function initGui(tO)
      if isempty(tO.fig)
        tO.initLesmots();
        tO.fig =GUIJournal(tO);
      end
    end

    function initLesmots(tO)
      tO.lesmots ={' '};
      tO.lesmots{end+1} =['D�but de la journalisation: ' datestr(now)];
      tO.lesmots{end+1} ='----------------------------------------------------------------------------';
    end

    %------------------------------
    % R�-afficher le GUI
    %------------------------------
    function afficher(tO, varargin)
      set(tO.fig, 'visible','on');
    end

    %------------------------------
    % Effacer tous les commentaires
    %------------------------------
    function reset(tO, varargin)
      tO.initLesmots();
      set(findobj('tag','Editorial'), 'value',1, 'string',tO.lesmots);
    end

    %---------------------------------------------
    % Ajouter un commentaire
    % EN entr�e
    %  T  texte � afficher/ajouter
    %  N  nombre d'espace � ajouter avant le texte
    %---------------------------------------------
    function ajouter(tO, T, Nesp)
      N =length(tO.lesmots)+1;
      if nargin == 3
        T =[char(ones(1,Nesp)*32) T];
      end
      tO.lesmots{N} =T;
      set(findobj('tag','Editorial'), 'string',tO.lesmots, 'value',N);
      tO.afficher();
    end

    %-----------------------------
    % Sauvegarder les commentaires
    %-----------------------------
    function sauve(tO, varargin)
      [fnom,pnom] =uigetfile('*.txt', 'Sauvegarder la Journalisation');
      if ~isnumeric(fnom)
        lenom =fullfile(pnom,fnom);
        tO.sauvegarde(lenom);
      end
    end

    %-------------------------------
    % Sauvegarder les commentaires
    % on fournit le path complet
    %-------------------------------
    function sauvegarde(tO, fichnom)
      if ~isempty(fichnom)
        fid =fopen(fichnom, 'w+');
        N =length(tO.lesmots);
        for U =1:N
          fprintf(fid, '%s\n', tO.lesmots{U});
        end
        fclose(fid);
      end
    end

  end  % methods

end