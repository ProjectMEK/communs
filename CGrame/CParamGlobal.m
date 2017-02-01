%
% classdef (Sealed) CParamGlobal < handle
%
% gestion des paramètres pour toutes les applications
% rien de spécifique à une seule application.
%
%

classdef (Sealed) CParamGlobal < handle

  properties (Access =private)
    %_______________________________________________
    % la propriété dispError devrait être consulté
    % avant d'afficher les message d'erreur.
    %
    %  valeur possible: est-ce que l'on affiche  --> qu'est-ce qu'on affiche
    %         0       :         non              --> on affiche pas
    %         1       :         oui              --> on affiche tout
    %         2       :         oui              --> on affiche identifier+message
    %         3       :         oui              --> on affiche message seulement
    %-----------------------------------------------
    dispError =1;

    % Est-ce que l'on travaille avec Matlab ou Octave
    matlab =true;
  end

  methods (Access =private)

    %------------
    % CONSTRUCTOR
    %------------------------
    function tO =CParamGlobal
      % Est-ce que l'on travaille avec Matlab ou Octave
      tO.matlabOctave();
    end

  end  % methods (Access =private)

  methods (Static)

    %-----------------------------------------------
    % Fonction static pour appeler l'instance/handle
    % de cette objet
    %-------------------------
    function sObj =getInstance
      persistent localObj;
      if isempty(localObj) || ~isa(localObj, 'CParamGlobal')
        localObj =CParamGlobal();
      end
      sObj =localObj;
    end

  end  %methods

  methods

    %-----------------------------------------------------
    % Comme il y a des différences de comportement dans le
    % traitement des erreurs, on va déterminer dans quelle
    % environnement on travaille.
    %-----------------------------------------------------
    function matlabOctave(tO)
      tO.matlab =isempty(ver('Octave'));
    end

    %--------------
    % GETTER/SETTER
    %-----------------------------
    function val =getMatlab(tO)
      val =tO.matlab;
    end
    %-----------------------------
    function val =getDispError(tO)
      val =tO.dispError;
    end
    %-----------------------------
    function setDispError(tO, val)
      tO.dispError =val;
    end

  end % method
end % classdef
