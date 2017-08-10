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
    % **** NE PAS OUBLIER D'IMPLÉMENTER LE DESTRUCTOR
    %      DANS LA CLASSE QUI VA HÉRITER DE CELLE-CI
    %------------------------------------------------
    function onDelete(tO)
      if ~isempty(tO.fig)
        delete(tO.fig);
      end
    end

    %-------------------
    % Création du GUI
    %-------------------
    function initGui(tO)
      if isempty(tO.fig)
        tO.initLesmots();
        tO.fig =GUIJournal(tO);
      end
    end

    %------------------------------
    % Effacer tous les commentaires
    %------------------------------
    function reset(tO, varargin)
      tO.initLesmots();
      set(tO.fig, 'visible','on');
      set(findobj('tag','Editorial'), 'value',1, 'string',tO.lesmots);
    end

    %-----------------------------
    % Ajouter un commentaire
    %-----------------------------
    function ajouter(tO, T)
      N =length(tO.lesmots)+1;
      tO.lesmots{N} =T;
      set(tO.fig, 'visible','on');
      set(findobj('tag','Editorial'), 'string',tO.lesmots, 'value',N);
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