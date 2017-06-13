%
% Classe CUnNoeudCirc
%
%  Noeud d'une liste générique
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
    % Associe la propriété .status à "status"
    % on limite aux valeurs logiques.
    %----------------------------------------
    function set.status(tO, status)
      tO.status =(status == true);
    end

  end %methods
end
