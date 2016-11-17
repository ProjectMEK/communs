%
% Classe CDefautFen
%
% Classe de base pour g�rer une Fen�tre
% tO --> thisObj
%
% methods
%   disparait(tO, src, event)
%   fenVisible(tO, etat)
%   togglevoir(tO, src, event)
%
classdef CDefautFen < handle
  properties
    fig;                   % handle de la figure
  end  %properties
  %------
  methods
    %___________________________________
    % rend la fen�tre invisible
    % sans la d�truire
    %-------
    function disparait(tO, src, event)
      set(tO.fig, 'visible','off');
    end
    %___________________________________
    % En fonction du param�tre "etat"
    % affiche ou non la fen�tre
    %-------
    function fenVisible(tO, etat)
      set(tO.fig, 'visible',etat);
    end
    %___________________________________
    % Peut �tre utilis� avec un bouton
    % pour toggler la visibilit� de la fen�tre
    %-------
    function togglevoir(tO, src, event)
      ss =CEOnOff.(get(tO.fig,'visible'));
      set(tO.fig, 'visible',char(CEOnOff(~ss)));
    end
  end  % methods
end