%
% Classe CHdchnl
% Ent�te des fichiers Analyse
% contiendra les infos sur les canaux/essais
%
% Ici on h�rite des fonction de la classe CGestionBase
%

classdef CHdchnl < CGestionBase

  properties
    %                    nad   est le nombre total de canaux
    %                    ess   est le nombre total d'essai
    Listadname =[];   % {nad}  ne sera pas sauvegard�
    adname =[];       % {nad}
    cindx =[];        % {nad}
    sweeptime =[];    % (nad, ess)
    rate =[];         % (nad, ess)
    nsmpls =[];       % (nad, ess)
    max =[];          % (nad, ess)
    min =[];          % (nad, ess)
    npoints =[];      % (nad, ess)
    point =[];        % (nad, ess)
    frontcut =[];     % (nad, ess)
    numstim =[];      % (ess)
    comment =[];      % {nad, ess}
  end

  methods

    %------------
    % CONSTRUCTOR
    %----------------------
    function tO = CHdchnl()
      tO.monnom ='CHdchnl';
    end

    %-----------------------------------------
    % On initialise les valeurs des propri�t�s
    % � partir d'une structure (Hd)
    %------------------------
    function initial(obj, Hd)
      initial@CGestionBase(obj, Hd);
      obj.ResetListAdname();
    end

    %------------------------------------
    % On reb�ti la propri�t� "Listadname"
    % afin de faire une liste des noms de canaux avec un num�ro
    %----------------------------
    function ResetListAdname(obj)
      obj.Listadname =obj.adname;
      for U =1:length(obj.adname)
        if U < 10
          obj.Listadname{U} =sprintf('%i  -%s', U, obj.adname{U});
        elseif U < 100
          obj.Listadname{U} =sprintf('%i -%s', U, obj.adname{U});
        else
          obj.Listadname{U} =sprintf('%i-%s', U, obj.adname{U});
        end
      end
    end

    %-------------------------
    function Hd =databrut(obj)
      Hd =databrut@CGestionBase(obj);
      Hd =rmfield(Hd, {'Listadname', 'monnom'});
    end

    %
    function clone =copie(obj)
      clone =copie@CGestionBase(obj);
    end

    %___________________________________________________________________________
    %
    % FONCTION POUR V�RIFIER LA DIMENSION DES DIFF�RENTES PROPRI�T�S DE LA CLASSE.
    % ON COMMENCE PAR COUPER L'EXC�DENT EN CANAUX ET ESSAIS, PUIS ON VOIT �
    % COMBLER SI IL MANQUE DES INFOS SUR LES CANAUX OU ESSAIS.
    %
    % EN ENTR�E: (NOMBRE_DE_CANAUX, NOMBRE_ESSAIS)
    %---------------------------------------------------------------------------
    function VerifSize(tO, CAN, ESS)
      if CAN < 1 | ESS < 1
        return;
      end
      %ON COMMENCE PAR ENLEVER L'EXC�DENT
      tO.couperExcedentCanEss(CAN, ESS);

      %PUIS ON COMBLE SI ON EST EN MANQUE
      tO.comblerCanEss(CAN, ESS);
    end

    %___________________________________________________________________________
    %
    % FONCTION POUR COUPER L'EXC�DENT EN CANAUX ET ESSAIS.
    % EN ENTR�E: (NOMBRE_DE_CANAUX, NOMBRE_ESSAIS)
    %---------------------------------------------------------------------------
    function couperExcedentCanEss(tO, Nad, Ess)
      tO.adname(Nad+1:end) =[];
      tO.cindx(Nad+1:end) =[];
      tO.ResetListAdname();
      tO.sweeptime(Nad+1:end, :) =[];
      tO.rate(Nad+1:end, :) =[];
      tO.nsmpls(Nad+1:end, :) =[];
      tO.max(Nad+1:end, :) =[];
      tO.min(Nad+1:end, :) =[];
      tO.npoints(Nad+1:end, :) =[];
      tO.point(Nad+1:end, :) =[];
      tO.frontcut(Nad+1:end, :) =[];
      tO.comment(Nad+1:end, :) =[];
      tO.sweeptime(:, Ess+1:end) =[];
      tO.rate(:, Ess+1:end) =[];
      tO.nsmpls(:, Ess+1:end) =[];
      tO.max(:, Ess+1:end) =[];
      tO.min(:, Ess+1:end) =[];
      tO.npoints(:, Ess+1:end) =[];
      tO.point(:, Ess+1:end) =[];
      tO.frontcut(:, Ess+1:end) =[];
      tO.comment(:, Ess+1:end) =[];
    end

    %___________________________________________________________________________
    %
    % FONCTION POUR COMBLER SI IL MANQUE DES INFOS SUR LES CANAUX OU ESSAIS.
    % ON NE TOUCHERA PAS AUX NOMS DE CANAUX CAR �A IMPLIQUE TROP DE CHANGEMENTS.
    %
    % EN ENTR�E: (NOMBRE_DE_CANAUX, NOMBRE_ESSAIS)
    %---------------------------------------------------------------------------
    function comblerCanEss(tO, Nad, Ess)
      if size(tO.sweeptime, 1) < Nad
        tO.sweeptime(end+1:Nad,:) =1;
      end
      if size(tO.sweeptime, 2) < Ess
        tO.sweeptime(:, end+1:Ess) =1;
      end
      if size(tO.rate, 1) < Nad
        tO.rate(end+1:Nad,:) =1;
      end
      if size(tO.rate, 2) < Ess
        tO.rate(:, end+1:Ess) =1;
      end
      if size(tO.nsmpls, 1) < Nad
        tO.nsmpls(end+1:Nad,:) =1;
      end
      if size(tO.nsmpls, 2) < Ess
        tO.nsmpls(:, end+1:Ess) =1;
      end
      if size(tO.max, 1) < Nad
        tO.max(end+1:Nad,:) =0;
      end
      if size(tO.max, 2) < Ess
        tO.max(:, end+1:Ess) =0;
      end
      if size(tO.min, 1) < Nad
        tO.min(end+1:Nad,:) =0;
      end
      if size(tO.min, 2) < Ess
        tO.min(:, end+1:Ess) =0;
      end
      if size(tO.npoints, 1) < Nad
        tO.npoints(end+1:Nad,:) =0;
      end
      if size(tO.npoints, 2) < Ess
        tO.npoints(:, end+1:Ess) =0;
      end
      if size(tO.point, 1) < Nad
        tO.point(end+1:Nad,:) =0;
      end
      if size(tO.point, 2) < Ess
        tO.point(:, end+1:Ess) =0;
      end
      if size(tO.frontcut, 1) < Nad
        tO.frontcut(end+1:Nad,:) =0;
      end
      if size(tO.frontcut, 2) < Ess
        tO.frontcut(:, end+1:Ess) =0;
      end
      if size(tO.comment, 1) < Nad
        tO.comment(end+1:Nad,:) ={[]};
      end
      if size(tO.comment, 2) < Ess
        tO.comment(:, end+1:Ess) ={[]};
      end
    end

    %------------------------------------------
    % Fonction pour dupliquer les canaux lescan
    % EN ENTR�E: ([NUM�RO DE CANAUX � DUPLIQUER])
    %--------------------------
    function duplic(obj,lescan)
      nbcan =length(lescan);
      for U =1:nbcan
        obj.adname{end+1} =obj.adname{lescan(U)};
        obj.cindx{end+1} =obj.nouvnom();
      end
      % comme on modifie le nombre de canaux, on reb�ti la liste
      obj.ResetListAdname();
      obj.sweeptime(end+1:end+nbcan,:) =obj.sweeptime(lescan,:);
      obj.rate(end+1:end+nbcan,:) =obj.rate(lescan,:);
      obj.nsmpls(end+1:end+nbcan,:) =obj.nsmpls(lescan,:);
      obj.max(end+1:end+nbcan,:) =obj.max(lescan,:);
      obj.min(end+1:end+nbcan,:) =obj.min(lescan,:);
      obj.npoints(end+1:end+nbcan,:) =0;
      obj.point(end+1:end+nbcan,:) =0;
      obj.frontcut(end+1:end+nbcan,:) =obj.frontcut(lescan,:);
      obj.comment(end+1:end+nbcan,:) =obj.comment(lescan,:);
    end

    %-----------------------
    % ajouter "nbcan" canaux
    % EN ENTR�E: (NOMBRE_DE_CANAUX_A_AJOUTER)
    %----------------------------
    function ajoutcan(obj, nbcan)
      for U =1:nbcan
        obj.adname{end+1} ='Nouveau canal';
        obj.cindx{end+1} =obj.nouvnom();
      end
      % comme on modifie le nombre de canaux, on reb�ti la liste
      obj.ResetListAdname();
      obj.sweeptime(end+1:end+nbcan,:) =1;
      obj.rate(end+1:end+nbcan,:) =1;
      obj.nsmpls(end+1:end+nbcan,:) =1;
      obj.max(end+1:end+nbcan,:) =0;
      obj.min(end+1:end+nbcan,:) =0;
      obj.npoints(end+1:end+nbcan,:) =0;
      obj.point(end+1:end+nbcan,:) =0;
      obj.frontcut(end+1:end+nbcan,:) =0;
      obj.comment(end+1:end+nbcan,:) ={[]};
    end

    %----------------------
    % Suppression de canaux
    % V contient la matrice des canaux � supprimer
    %
    % ex.  tO.SuppCan([1 5 7]);
    %----------------------
    function SuppCan(tO, V)
      nbcan =length(tO.adname);
      if sum(V > nbcan) > 0
        disp('erreur dans les canaux � enlever');
        return;
      end
    	tmp =1:nbcan;
    	tmp(V) =[];
      tO.adname =tO.adname(tmp);
      tO.cindx =tO.cindx(tmp);
      % comme on modifie le nombre de canaux, on reb�ti la liste
      tO.ResetListAdname();
      tO.sweeptime(V,:) =[];
      tO.rate(V,:) =[];
      tO.nsmpls(V,:) =[];
      tO.max(V,:) =[];
      tO.min(V,:) =[];
      tO.npoints(V,:) =[];
      tO.point(V,:) =[];
      tO.frontcut(V,:) =[];
      tO.comment =tO.comment(tmp,:);
    end

    %-----------------------------------------
    % Ajoute des essai dans le fichier courant
    % EN ENTR�E: (NOMBRE_D'ESSAI_A_AJOUTER)
    %----------------------------
    function ajoutess(obj, nbess)
      if nbess < 1
        return;
      end
      obj.sweeptime(:,end+1:end+nbess) =1;
      obj.rate(:,end+1:end+nbess) =1;
      obj.nsmpls(:,end+1:end+nbess) =1;
      obj.max(:,end+1:end+nbess) =0;
      obj.min(:,end+1:end+nbess) =0;
      obj.npoints(:,end+1:end+nbess) =0;
      obj.point(:,end+1:end+nbess) =0;
      obj.frontcut(:,end+1:end+nbess) =0;
      obj.numstim(end+1:end+nbess) =0;
      obj.comment(:,end+1:end+nbess) ={[]};
    end

    %----------------------------------------------
    % Forger un nouveau NOM UNIQUE pour la variable
    % du prochain canal � ajouter ou renommer.
    %
    %---------------------------
    function lenom =nouvnom(obj)
      vL =1;
      for V =1:length(obj.cindx)
      	if length(obj.cindx{V}) > vL
      		vL =length(obj.cindx{V});
      	end
      end
      tt ={};
      for V =1:length(obj.cindx)
      	if length(obj.cindx{V}) == vL
          tt{end+1} =obj.cindx{V};
        end
      end
      tt =sort(tt);
      tt =tt{end};
      lesnum ={};
      for U =48:57, lesnum{end+1} =char(U); end
      grand ={};
      for U =65:90, grand{end+1} =char(U); end
      petit ={};
      for U =97:122, petit{end+1} =char(U); end
      pareil =true;
      while pareil
        switch tt(end)
        %----------
        case lesnum
          lalet =double(tt(end));
          if lalet == 57
            tt(end) =char(65);
          else
            tt(end) =char(lalet+1);
          end
        %---------
        case grand
          lalet =double(tt(end));
          if lalet == 90
            tt(end) =char(97);
          else
            tt(end) =char(lalet+1);
          end
        %---------
        case petit
          lalet =double(tt(end));
          if lalet == 122
            tt(end+1) ='0';
          else
            tt(end) =char(lalet+1);
          end
        end
        pareil =ismember(tt, obj.cindx);
      end
      lenom =tt;
    end

  end  %methods
end  %classdef
