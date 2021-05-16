%
% Classe CUneListe
%
%  Gestion d'une liste bi-directionelle
%
% *** CARACTÉRISTIQUES ***
% la propriété "prev" du noeud "tO.premier" sera toujours vide
%   isempty(tO.premier.prev)  --> true
%
% la propriété "next" du dernier noeud sera toujours vide
%   tO.cur = tO.premier;
%   while ~isempty (tO.cur.next)
%     tO.cur = tO.cur.next;
%   end
%   isempty(tO.cur.next)  --> true
%
%-----------------------------------------------------------
classdef CUneListe < handle

  properties
    premier =[];      % handle du premier noeud créer
    cur =[];          % handle du noeud actif
  end

  methods

    %-------------------------------------------
    % DESTRUCTOR
    % On met à vide les pointeurs sur les noeuds
    % avant de détruire les noeuds
    %-------------------------------------------
    function delete(thisObj)
      if ~isempty(thisObj.premier)
        thisObj.cur =thisObj.premier;
        thisObj.premier =[];
        S =thisObj.cur.next;
        delete(thisObj.cur)
        while ~isempty(S)
          thisObj.cur =S;
          S =S.next;
          delete(thisObj.cur);
        end
      end
      tO.cur =[];
    end

    %-------------------------------------
    % Création d'un nouveau noeud
    %-------------------------------------
    function NOEUD = nouveau(thisObj, hdt)

      if nargin == 1
        hdt =[];
      end
      NOEUD =CUnNoeud(hdt);

    end

    %-------------------------------------------------------
    % Ajouter un noeud à l'avant de tO.cur
    %   noeud --> nouveau noeud à insérer (facultatif)
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %-------------------------------------------------------
    function varargout = ajoutNoeud(tO, noeud)

      % si on ne passe pas de noeud, on doit en créer un
      if nargin < 2
        noeud =tO.nouveau();
      end

      if isempty(tO.premier)
        tO.premier =noeud;
      else
        if isempty(tO.cur)
          tO.allerFin();
        end
        tO.putApresCur(noeud);
      end

      tO.cur =noeud;

      % en sortie on peut obtenir le handle du nouveau
      if nargout
        varargout{1} =noeud;
      end

    end

    %------------------------------------------------------------
    % Déplacement du noeud ENTRANSFERT après le noeud NOEUDAVANT.
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %------------------------------------------------------------
    function moveApres(tO, NOEUDAVANT, ENTRANSFERT)
      tO.cur =NOEUDAVANT;
      ENTRANSFERT.disConnect();
      tO.putApresCur(ENTRANSFERT);
      tO.cur =ENTRANSFERT;
    end

    %------------------------------------------------------------
    % Déplacement du noeud ENTRANSFERT après le noeud NOEUDAPRES.
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %------------------------------------------------------------
    function moveAvant(tO, NOEUDAPRES, ENTRANSFERT)
      tO.cur =NOEUDAPRES;
      ENTRANSFERT.disConnect();
      tO.putAvantCur(ENTRANSFERT);
      tO.cur =ENTRANSFERT;
    end

    %-------------------------------------------
    % On introduit le noeud "NOEUD" avant ".cur"
    %-------------------------------------------
    function putAvantCur(tO, NOEUD)
      if isempty(tO.cur.prev)
        tO.premier =NOEUD;
      else
        tO.cur.prev.next =NOEUD;
      end
      NOEUD.prev =tO.cur.prev;
      NOEUD.next =tO.cur;
      tO.cur.prev =NOEUD;
    end

    %-------------------------------------------
    % On introduit le noeud "NOEUD" après ".cur"
    %-------------------------------------------
    function putApresCur(tO, NOEUD)
      if ~isempty(tO.cur.next)
        tO.cur.next.prev =NOEUD;
      end
      NOEUD.next =tO.cur.next;
      tO.cur.next =NOEUD;
      NOEUD.prev =tO.cur;
    end

    %---------------------------------------
    % Positionner "cur" sur le dernier noeud
    %---------------------------------------
    function allerFin(tO)
      tO.allerDebut();
      if ~isempty(tO.cur)
        while ~isempty(tO.cur.next)
          tO.cur =tO.cur.next;
        end
      end
    end

    %---------------------------------------
    % Positionner "cur" sur le premier noeud
    %---------------------------------------
    function allerDebut(tO)
      tO.cur =tO.premier;
    end

    %--------------------------
    function MetStatusAZero(thisObj)
      S =thisObj.premier;
      while ~isempty(S.next)
        S.status =0;
        S =S.next;
      end
    end

  end %methods
end
