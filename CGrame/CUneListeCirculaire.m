%
% Classe CUneListeCirculaire
%
%  Gestion d'une liste circulaire
%
%  On aura encore tO.premier pour nous indiquer le premier noeud
%  et le dernier noeud aura noeud.status = true
%
classdef CUneListeCirculaire < CUneListe

  %______
  methods

    %---------------------------
    % Création d'un nouveau noeud
    %-----------------------------
    function NOEUD = nouveau(thisObj, hdt)

      if nargin == 1
        hdt =[];
      end
      NOEUD =CUnNoeudCirc(hdt);

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
        noeud.status =true;
        noeud.prev =noeud;
        noeud.next =noeud;
      else
        if isempty(tO.cur)
          tO.allerFin();
        end
        tO.connectApres(noeud);
      end

      tO.cur =noeud;

      % en sortie on peut obtenir le handle du nouveau
      if nargout
        varargout{1} =noeud;
      end

    end

    %---------------------------------------
    % connecte le noeud "noeud" après tO.cur
    %---------------------------------------
    function connectApres(tO, noeud)
      noeud.status =tO.cur.status;
      tO.cur.status =false;
      tO.putApresCur(noeud);
    end

    %---------------------------------------
    % connecte le noeud "noeud" avant tO.cur
    %---------------------------------------
    function connectAvant(tO, noeud)
      if tO.cur.prev.status
        % ça veut dire que tO.cur est le premier
        tO.premier =noeud;
      end
      noeud.status =false;
      tO.putAvantCur(noeud);
    end

    %------------------------------------------------------------
    % Déplacement du noeud ENTRANSFERT après le noeud NOEUDAVANT.
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %------------------------------------------------------------
    function moveApres(tO, NOEUDAVANT, ENTRANSFERT)
      tO.cur =NOEUDAVANT;
      ENTRANSFERT.disConnect();
      tO.connectApres(ENTRANSFERT);
      tO.cur =ENTRANSFERT;
    end

    %------------------------------------------------------------
    % Déplacement du noeud ENTRANSFERT après le noeud NOEUDAPRES.
    % Puis, on repositionne tO.cur sur le noeud ENTRANSFERT.
    %------------------------------------------------------------
    function moveAvant(tO, NOEUDAPRES, ENTRANSFERT)
      tO.cur =NOEUDAPRES;
      ENTRANSFERT.disConnect();
      tO.connectAvant(ENTRANSFERT);
      tO.cur =ENTRANSFERT;
    end

    %--------------------------------------------------------
    % Ajouter un noeud à l'avant de cur
    % En entrée  cur   --> noeud de référence pour l'ajout
    %            noeud --> nouveau noeud à insérer (facultatif)
    %--------------------------------------------------------
    function varargout = ajoutNoeudApres(tO, cur, noeud)

      % si on ne passe pas de noeud, on doit en créer un
      if nargin < 3
        noeud =tO.nouveau();
      end

      noeud.next =cur.next;
      noeud.status =cur.status;
      cur.next =noeud;
      cur.status =false;

      % en sortie on peut obtenir le handle du nouveau
      if nargout
        varargout{1} =noeud;
      end

    end

    %---------------------------------------
    % Positionner "cur" sur le dernier noeud
    % son status est "true"
    %---------------------------------------
    function allerFin(tO)
      if ~isempty(tO.premier)
        tO.cur =tO.premier;
        while ~tO.cur.status
          tO.cur =tO.cur.next;
        end
      end
    end

  end
end