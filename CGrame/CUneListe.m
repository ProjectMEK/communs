%
% Classe CUneListe circulaire
%
%  Gestion d'une liste
%
% � RETESTER AVANT D'UTILISER
%
classdef CUneListe < handle

  properties
    premier =[];      % handle du premier noeud cr�er
    cur =[];          % handle du noeud actif (pour la lecture dans AV)
  end

  methods

    %------------
    % CONSTRUCTOR
    %----------------------------
    function thisObj =CUneListe()
      % rien pour l'instant
    end

    %-----------
    % DESTRUCTOR
    %-----------------------
    function delete(thisObj)
      if ~isempty(thisObj.premier)
        thisObj.cur =thisObj.premier;
        S =thisObj.cur.next;
        thisObj.cur.next =[];
        thisObj.cur =S;
        while ~isempty(thisObj.cur.next)
          S =thisObj.cur.next;
          delete(thisObj.cur);
          thisObj.cur =S;
        end
        delete(thisObj.premier);
      end
    end

    %---------------------------
    % � revoir avant d'utiliser
    % je l'ai r�-impl�ment� dans Cinegraf
    % et �a fonctionne bien.
    %-------------------------------
    function Nouveau(thisObj, hData)
      hnd =CUnNoeud();
      if isempty(thisObj.premier)
        thisObj.premier =hnd;
        thisObj.cur =hnd;
        hnd.next =hnd;
      else
        hnd.next =thisObj.cur.next;
      end
      thisObj.cur.next =hnd;
      hnd.hbuf =hData;
    end

    %--------------------------
    function MiseAZero(thisObj)
      S =thisObj.premier;
      S.status =2;
      while ~isempty(S.next) && ~(S.next.status == 2)
        S =S.next;
        S.status =0;
      end
      thisObj.premier.status =0;
    end

  end %methods
end
