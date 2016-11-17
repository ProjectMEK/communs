%
% Classe CUnNoeud
%
%  Noeud d'une liste g�n�rique
%
classdef CUnNoeud < handle
  properties
    status =false;  % true: je peux le lire et false: je peux l'�crire
    next =[];       % handle du noeud suivant
    hbuf =[];       % handle des datas
    buf;            % data
  end %properties
  %------
  methods
    function delete(thisObj)          % DESTRUCTOR
      if ~isempty(thisObj.hbuf)
        delete(thisObj.hbuf);
      end
    end
  end %methods
end
