%
% Classe CUnNoeudCirc
%
%  Noeud d'une liste g�n�rique
%
classdef CUnNoeudCirc < CUnNoeud

  properties
    status =false;  % true: dernier noeud par exemple
  end

  %------
  methods

    %------------
    % CONSTRUCTOR
    %------------
    function tO = CUnNoeudCirc(data)
      if nargin
        tO.buf =data;
      end
    end

    %----------------------------------------
    % Associe la propri�t� .status � "status"
    % on limite aux valeurs logiques.
    %----------------------------------------
    function set.status(tO, status)
      tO.status =(status == true);
    end

  end %methods
end
