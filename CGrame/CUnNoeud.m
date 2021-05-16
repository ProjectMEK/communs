%
% Classe CUnNoeud
%
%  Noeud d'une liste g�n�rique bi-directionelle
%
classdef CUnNoeud < handle

  properties
    next =[];       % handle du noeud suivant
    prev =[];       % handle du noeud pr�c�dent
    buf =[];        % data
  end %properties

  %------
  methods

    %------------
    % CONSTRUCTOR
    %------------
    function tO = CUnNoeud(data)
      if nargin
        tO.buf =data;
      end
    end

    %------------------
    % DESTRUCTOR
    %------------------
    function delete(tO)
      tO.disConnect();
    end

    %---------------------------------------------------------
    % Si on a stocker des objets dans "buf" on peut les vider
    % avec la function tO.vide()
    %---------------------------------------------------------
    function vide(tO)
      if ~isempty(tO.buf)
        delete(tO.buf);
        tO.buf =[];
      end
    end

    %-------------------------------------
    % D�connecte le noeud de la liste
    % et reconnecte les noeuds avant/apr�s
    %-------------------------------------
    function disConnect(tO)
      avant =tO.prev;
      apres =tO.next;
      tO.next =[];
      tO.prev =[];
      if ~isempty(avant)
        avant.next =apres;
      end
      if ~isempty(apres)
        apres.prev =avant;
      end
    end

    %------------------------------------
    % Associe la propri�t� .next � "next"
    %------------------------------------
    function set.next(tO, next)
      tO.next =next;
    end

    %------------------------------------
    % Associe la propri�t� .prev � "prev"
    %------------------------------------
    function set.prev(tO, prev)
      tO.prev =prev;
    end

    %----------------------------------
    % Associe la propri�t� .buf � "buf"
    %----------------------------------
    function set.buf(tO, buf)
      tO.buf =buf;
    end

  end %methods
end
