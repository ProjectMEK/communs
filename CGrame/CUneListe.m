%
% Classe CUneListe
%
%  Gestion d'une liste bi-directionelle
%
% *** CARACT�RISTIQUES ***
% la propri�t� "prev" du noeud "tO.premier" sera toujours vide
%   isempty(tO.premier.prev)  --> true
%
% la propri�t� "next" du dernier noeud sera toujours vide
%   tO.cur = tO.premier;
%   while ~isempty (tO.cur.next)
%     tO.cur = tO.cur.next;
%   end
%   isempty(tO.cur.next)  --> true
%
%-----------------------------------------------------------
classdef CUneListe < handle

  properties
    premier =[];      % handle du premier noeud cr�er
    cur =[];          % handle du noeud actif
  end

  methods

    %-------------------------------------------
    % DESTRUCTOR
    % On met � vide les pointeurs sur les noeuds
    % avant de d�truire les noeuds
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
    % Cr�ation d'un nouveau noeud
    %-------------------------------------
    function NOEUD = nouveau(thisObj, hdt)

      if nargin == 1
        hdt =[];
      end
      NOEUD =CUnNoeud(hdt);

    end

    %-------------------------------------------------------
    % Ajouter un noeud � l'avant de tO.cur
    %   noeud --> nouveau noeud � ins�rer (facultatif)
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %-------------------------------------------------------
    function varargout = ajoutNoeud(tO, noeud)

      % si on ne passe pas de noeud, on doit en cr�er un
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
    % D�placement du noeud ENTRANSFERT apr�s le noeud NOEUDAVANT.
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %------------------------------------------------------------
    function moveApres(tO, NOEUDAVANT, ENTRANSFERT)
      tO.cur =NOEUDAVANT;
      ENTRANSFERT.disConnect();
      tO.putApresCur(ENTRANSFERT);
      tO.cur =ENTRANSFERT;
    end

    %------------------------------------------------------------
    % D�placement du noeud ENTRANSFERT apr�s le noeud NOEUDAPRES.
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
    % On introduit le noeud "NOEUD" apr�s ".cur"
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
