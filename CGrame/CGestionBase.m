%
% classdef CGestionBase < handle
%
% METHODS
%   clone =copie(tO)
%       V =databrut(tO)
%          initial(tO, V)
%          ResetProp(tO)
%
%  Contient toutes les m�thodes de bases pour les classes
%  qui ont des propri�t�s qui doivent �tre sauvegarder.
%  **** la propri�t� "monnom" doit �tre initialis� ****
%
classdef CGestionBase < handle
  properties
    monnom ='';
  end  %properties
  %------
  methods
    %-------------------------------
    % initial, change les properties
    % � partir d'une structure
    %-------
    function initial(tO, V)
      CDefautFncBase.initial(tO, tO.monnom, V);
    end
    %---------------------------------
    % databrut retourne une structure
    % � partir des properties de tO.monnom
    %-------
    function V =databrut(tO)
      V =CDefautFncBase.databrut(tO, tO.monnom);
    end
    %-------------------------------
    % ResetProp remet les properties
    % aux valeurs par d�fauts
    %-------
    function ResetProp(tO)
      CDefautFncBase.ResetProp(tO, tO.monnom);
    end
    %---------------------------------------------------
    % copie retourne un objet avec les properties actuel
    %-------
    function clone =copie(tO)
      clone =CDefautFncBase.copie(tO, tO.monnom);
    end
  end  %methods
end
