%
% Classe CFichier
%
% Classe de Base pour la gestion des fichiers au format d'Analyse,
% ind�pendante des applications. Elle sera h�rit�e par d'autres classes 
% du genre CFichierAnalyse.
%
% MEK - mai 2009
%

classdef CFichier < handle

  properties
    Info =[];
    Vg =[];
    Hdchnl =[];
    Ptchnl =[];
    % Tpchnl;     % voir CFichierAnalyse
    Catego =[];
    autre =[];
  end

  properties (SetAccess = private)
    NouvelVersion =7.08;
  end

  methods

    %------------------------------------------------
    % Anciennement la fonction CONSTRUCTOR "CFichier"
    %------------------------------------------------
    function initCFichier(thisObj)

      try
        thisObj.Info =CFinfo();
        thisObj.Hdchnl =CHdchnl();
        thisObj.Ptchnl =CPtchnl(thisObj);
        thisObj.Catego =CCatego();
        thisObj.Catego.hF =thisObj;
      catch moo;
        CQueEsEsteError.dispOct(moo);
        rethrow(moo);
      end

    end

    % DESTRUCTOR
    function delete(thisObj)
      delete(thisObj.Info);
      delete(thisObj.Vg);
      delete(thisObj.Hdchnl);
      delete(thisObj.Ptchnl);
      delete(thisObj.Catego);
    end

    %----------------------------------------
    % GETTER-SETTER
    % pour la propri�t�: NouvelleVersion
    %----------------------------------------
    function val = get.NouvelVersion(thisObj)
      val =thisObj.NouvelVersion;
    end

    function thisObj = set.NouvelVersion(thisObj, ~)
      % rien � faire, on ne touche pas � cette propri�t�
    end

    %------------------------------------
    % FIND  (overload)
    % Si on a plusieurs fichiers ouverts,
    % on peut vouloir les comparer
    %------------------------------
    function Cok =find(thisObj,OFi)

      try
        % version Matlab
        Cok =(thisObj == OFi);
      catch moo;
        % version Octave
        Cok =false;

        % il faut au moins que les 2 soient des objets de la m�me classe
        if strcmp(class(thisObj), class(OFi))
          % la strat�gie est d'utiliser une propri�t� unique connue si elle
          % est identique dans les deux cas, c'est forc�ment le m�me handle
          Cok =strcmp(thisObj.Info.fitmp, OFi.Info.fitmp);
        end

      end

    end

    %-------------------------------
    % On copie les canaux du fichier
    % vers un fichier temporaire
    %-------------------
    function copycan(tO)
      try
        % on v�rifie si une waitbar est active
        hwb =findall(0, 'type','figure', 'name','WBarLecture');
        TextLocal ='Cr�ation du fichier temporaire de travail';
        delwb =false;
        if isempty(hwb)
          delwb =true;
          hwb =waitbar(0.001, TextLocal);
        else
          waitbar(0.001, hwb, TextLocal);
        end

        % Fichier source, vrai fichier
        Fsrc =fullfile(tO.Info.prenom, tO.Info.finame);
        % Fichier destination, fichier temporaire de travail
        Fdst =tO.Info.fitmp;

        ncan =tO.Vg.nad;
        hdchnl =tO.Hdchnl;
        laver ='-V7';

      	% nom de la variable du premier canal
      	lenom =hdchnl.cindx{1};
      	% on load le premier canal
      	A =load(Fsrc, lenom);
      	% on le sauve dans le fichier temporaire
%      	save(Fdst, '-struct', 'A', laver);
      	save(Fdst, '-struct', 'A');

%**************************************************************************************
% lemot =sprintf('CFichier.copycan --> rendu ici laver ou pas, voir avec Matlab...\n');
% disp(lemot);


        % puis on fait la m�me chose pour les autres canaux
        for U =2:ncan
        	waitbar(0.95*single(U)/single(ncan), hwb);
        	A =[];
        	lenom =hdchnl.cindx{U};
        	A =load(Fsrc, lenom);
        	save(Fdst, '-struct', 'A', '-append');
        end

        % Si on a cr�� un waitbar, on le delete
        if delwb
          delete(hwb);
        end

      catch moo;
        CQueEsEsteError.dispOct(moo);
        rethrow(moo);
      end

    end

    %---------------------------------
    % Copie data du canal source (src)
    % vers le canal destination (dst)
    %-------------------------------------
    function CopieCanal(thisObj, src, dst)
      hDt =CDtchnl();
      thisObj.getcanal(hDt, src);
      thisObj.setcanal(hDt, dst);
    end

    %-----------------------------------
    % R�cup�re 1 canal (tous les essais)
    % HDt --> handle sur un objet CDtchnl()
    % can --> num�ro du canal
    %-----------------------------------
    function getcanal(thisObj, HDt, can)
      if nargin == 3
        HDt.Nom =thisObj.Hdchnl.cindx{can};
      end
      if isempty(whos('-file', thisObj.Info.fitmp, HDt.Nom))
      	a.(HDt.Nom) =[];
      	HDt.Dato =a;
      else
        HDt.Dato =load(thisObj.Info.fitmp, HDt.Nom);
      end
    end

    %-------------------------------------
    % R�cup�re 1 canal pour les essais ess
    % HDt --> handle sur un objet CDtchnl()
    % ess --> num�ro des essais � lire
    % can --> num�ro du canal
    %-----------------------------------------
    function getcaness(thisObj, HDt, ess, can)

      if nargin == 4
        HDt.Nom =thisObj.Hdchnl.cindx{can};
      end
      if isempty(whos('-file', thisObj.Info.fitmp, HDt.Nom))
      	a.(HDt.Nom) =[];
      	HDt.Dato =a;
      else
        s =load(thisObj.Info.fitmp, HDt.Nom);
        HDt.Dato.(HDt.Nom) =s.(HDt.Nom)(:,ess);
      end

    end

    %-----------------------------------------
    % sauvegarde le canal avec tous ses essais
    % HDt --> handle sur un objet CDtchnl()
    % can --> num�ro du canal
    %-----------------------------------
    function setcanal(thisObj, HDt, can)
      if nargin == 3
        thisObj.rename(HDt, can);
      end
      p =HDt.Dato;
      save(thisObj.Info.fitmp, '-Struct', 'p', HDt.Nom, '-Append');
    end

    %----------------------------------------
    % sauvegarde le canal pour les essais ess
    % HDt --> handle sur un objet CDtchnl()
    % ess --> num�ro des essais � lire
    % can --> num�ro du canal
    function setcaness(thisObj, HDt, ess, can)
      if nargin == 4
        thisObj.rename(HDt, can);
      end
      p =load(thisObj.Info.fitmp, HDt.Nom);
      if isempty(HDt.Dato.(HDt.Nom))
   	    p.(HDt.Nom)(:,ess) =[];
      elseif ~isfield(p, HDt.Nom)
  	    p.(HDt.Nom)(:,ess) =HDt.Dato.(HDt.Nom);
  	  else
  	  	a =size(HDt.Dato.(HDt.Nom), 1);
  	  	p.(HDt.Nom)(1:a,ess) =HDt.Dato.(HDt.Nom);
      end
      save(thisObj.Info.fitmp, '-Struct', 'p', HDt.Nom,'-Append');
    end

    %----------------------------
    % Delete les datas d'un canal
    %   can --> num�ro du canal
    %----------------------------
    function delcan(thisObj, can)
      HDt =CDtchnl();
      for U =1:length(can)
        % lire le nom de la variable du canal
      	HDt.Nom =thisObj.Hdchnl.cindx{can(U)};
        % on vide les datas
      	HDt.Dato.(HDt.Nom) =[];
        % on sauvegarde
      	thisObj.setcanal(HDt);
      end
      delete(HDt);
    end

    %----------------------
    % delete les essais ess
    %  ess --> num�ro des essais
    %----------------------------
    function deless(thisObj, ess)
      HDt =CDtchnl();
      hwb =waitbar(0, 'canal: ');
      %________________________________________________________________________
      % comme chaque canal est conserv� dans une variable s�par�ment,
      % il faudra faire le tour de tout les canaux pour effacer les essais ess
      %------------------------------------------------------------------------
      for U =1:thisObj.Vg.nad
      	waitbar(U/thisObj.Vg.nad, hwb, ['canal: ' num2str(U)]);
        % lecture du nom du canal
      	HDt.Nom =thisObj.Hdchnl.cindx{U};
        % mise � z�ro des essais
      	HDt.Dato.(HDt.Nom) =[];
        % sauvegarde du canal pour les essais ess
      	thisObj.setcaness(HDt, ess);
      end
      delete(HDt);
      delete(hwb);
    end

    %----------------------------------
    % On fait une revision des stimulus
    % pour s'assurer qu'ils ne sont pas vides
    %-----------------------------
    function StimulusVide(thisObj)
      % On commence par enlever les cellules vides
      for V =length(thisObj.Vg.nomstim):-1:1
        if isempty(strtrim(thisObj.Vg.nomstim{V}))
          thisObj.Vg.nomstim(V) =[];
        end
      end
      if isempty(thisObj.Vg.nomstim)
        % On a pas de stimulu, on en cr� un bidon
        thisObj.Vg.nst =1;
        thisObj.Vg.nomstim ={'Bidon'};
        thisObj.Hdchnl.numstim =ones(1, thisObj.Vg.ess);
      else
      	% on ajuste les param�tres
      	thisObj.Vg.nst =length(thisObj.Vg.nomstim);
      	test =zeros(1, thisObj.Vg.ess);
      	N =min(length(test), length(thisObj.Hdchnl.numstim));
      	test(1:N) =thisObj.Hdchnl.numstim(1:N);
      	thisObj.Hdchnl.numstim =test;
      end
    end

    %------------------------------------------
    % On s'assure que les stimulus sont uniques
    % ------------------------------
    function StimulusUnique(thisObj)
      vg =thisObj.Vg;
      hdchnl =thisObj.Hdchnl;
      ref =vg.nomstim;
      U =1;
      while(U < vg.nst)
        test =strcmpi(vg.nomstim{U}, vg.nomstim);
      	if sum(test) > 1
      		tt =find(test);
      	  vg.nomstim(tt(2:end)) =[];
      	  vg.nst =length(vg.nomstim);
      	end
      	U =U+1;
      end
      letest =find(hdchnl.numstim > length(ref));
      if ~isempty(letest)
      	hdchnl.numstim(letest) =0;
      end
      lesess =find(hdchnl.numstim > 0);
      for U =lesess
      	test =strcmpi(ref{hdchnl.numstim(U)}, vg.nomstim);
      	ss =find(test);
      	if isempty(ss)
      	  ss =0;
      	end
      	hdchnl.numstim(U) =ss;
      end
    end

    %-----------------------------------------------
    % les essais non-assign�s seront class�s "bidon"
    %---------------------------------
    function StimEssVideBidon(thisObj)
      vg =thisObj.Vg;
      hdchnl =thisObj.Hdchnl;
      % recherche de la position des bidons
   	  ss =find(hdchnl.numstim == 0 | hdchnl.numstim > vg.nst);
   	  if ~isempty(ss)
        test =strcmpi('bidon', vg.nomstim);
        if sum(test) == 0
      	  vg.nst =vg.nst+1;
      	  vg.nomstim{vg.nst} ='bidon';
      	  bidon =vg.nst;
        else
        	bidon =find(test);
        end
    	  hdchnl.numstim(ss) =bidon;
   	  end
    end

    %-------------------------------------------
    % Renommer la variable qui contient le canal
    % HDt --> handle sur un objet CDtchnl()
    % can --> num�ro du canal
    %---------------------------------
    function rename(thisObj, HDt, can)
      lenom =thisObj.Hdchnl.cindx{can};
      HDt.rename(lenom);
    end

    %------------------------------
    % Retourne le size du canal can
    % can --> num�ro du canal
    %--------------------------------
    function Dt =sizecan(thisObj,can)
      ss =whos('-file', thisObj.Info.fitmp, thisObj.Hdchnl.cindx{can});
      Dt =ss.size;
    end

    %-------------------------------------
    % [Ok] = ASSEZPT(LesCan, NbPt, LesEss)
    %
    % Cette fonction va v�rifier si on a le bon nombre de point demand�.
    % En entr�e: les canaux � v�rifier, le nombre de point n�cessaire
    %            (1 par d�faut), les essais (1:vg.ess par d�faut).
    % En sortie: si il y a erreur, [1],  autrement [0]
    %-------------------------------------------
    function lasortie =assezpt(thisObj,varargin)
      if nargin <= 1
        lasortie =true;
        return;
      end
      lasortie =false;
      % variable des infos sur les canaux/essais
      hdchnl =thisObj.Hdchnl;
      % variable des infos des points marqu�s
      ptchnl =thisObj.Ptchnl;
      % variable des infos globales
      vg =thisObj.Vg;
      lescan =varargin{1};
      nbpt =1;
      lesess =[1:vg.ess];
      if nargin == 3
        nbpt =varargin{2};
      elseif nargin > 3
        nbpt =varargin{2};
        lesess =varargin{3};
      end
      %**********************************************************
      % L'affichage d'erreur se fait dans la fen�tre de commande.
      % Comme on utilise des caract�res ASCII > 128, �a demande
      % une pirouette suppl�mentaire (retour au bon vieux "DOS" d'autrefois).
      %**********************************************************************
      sdl =[char(13) char(10)];
      ctok =1;
      legros =max(nbpt);
      for ii =1:length(lescan)
        ss =find(hdchnl.npoints(lescan(ii),lesess) < legros);
        if length(ss)
          if ctok
            disp([num2str(legros) ' point(s) sont requis pour cette fonction.']);
          end
          lastr =[sdl 'Pour le canal ' num2str(lescan(ii)) ', les essais suivants sont a corriger:'];
          disp([lastr sdl num2str(lesess(ss))]);
          ctok =0;
          lasortie =true;
        end
        ctiok =[];
        for jj =lesess
          for uu =1:length(nbpt)
            if (hdchnl.npoints(lescan(ii),jj)>=nbpt(uu)) & (ptchnl.Dato(nbpt(uu),hdchnl.point(lescan(ii),jj),2) == -1)
              ctiok =[ctiok ' ' num2str(jj)];
            end
          end
        end
        if length(ctiok)
          lasortie =true;
          disp([sdl 'point bidon: essai #' ctiok]);
        end
      end
    end

    %-------------------------------------------------
    % Proc�de au marquage d'un point, voir "CPtchnl.m"
    %-------------------------------------------------------
    function marqettyp(thisObj,canal,essai,point,temps,type)
      thisObj.Ptchnl.marqettyp(canal,essai,point,temps,type);
    end

    %---------------------------------
    % initialise Ptchnl et met � jour:
    %   -  la matrice des points marqu�s
    %   -  thisObj.Hdchnl
    %--------------------------
    function initpoint(thisObj)
      % variable des infos sur les canaux/essais
      Hd =thisObj.Hdchnl;
      % variable des infos des points marqu�s
      Pt =thisObj.Ptchnl;
      % nombre maximum de point marqu� dans ce fichier
      tmp =max(Hd.npoints(:));
      if tmp > 0 && ~isempty(Pt.Dato)
        % on a des points marqu�s
        % quel canal/essai en a
        ptmp =find(Hd.npoints(:) > 0);
        % on se fait un backup de la matrice des infos des points marqu�s
        Dato =Pt.Dato;
        if size(Dato, 3) == 1
          foo =size(Dato);
          Dato(:,:,2) =zeros(foo);
        end
        % mise � z�ro de la matrice des infos des points marqu�s
        Pt.Dato =zeros(tmp,length(ptmp),2);
        % Il reste � reb�tir la matrice des points marqu�s � partir
        % des infos canal/essais (Hdchnl) et du backup (Dato)
        for U =1:length(ptmp)
          Pt.Dato(1:Hd.npoints(ptmp(U)),U,:) =Dato(1:Hd.npoints(ptmp(U)),Hd.point(ptmp(U)),1:2);
          ttest =find(Pt.Dato(1:Hd.npoints(ptmp(U)),U,1) > Hd.nsmpls(ptmp(U)));
          if ~isempty(ttest)
            Pt.Dato(ttest,U,2) =-1;
          end
          Hd.point(ptmp(U)) =U;
        end
      end
    end

    %-----------------------------
    % reb�ti la variable vg.lesess
    % qui est uitlis� pour afficher les essais avec
    % un nom de cat�gorie ou de stimulus...
    %-----------------------
    function lesess(thisObj)
    % vg.defniv sert � afficher les cat�gories du niveau d�sir� plut�t que d'indiquer le stimulus.
      vg =thisObj.Vg;
      cc =thisObj.Catego.Dato;
      L =cell(1,vg.ess);
      % On v�rifie si on a des stimulus
   	  tlet =0;
      for U =1:vg.niveau
        if strcmpi(strtrim(cc(1,U,1).nom),'stimulus')
          tlet =U;
          break;
        end
      end
      if tlet
        S =zeros(vg.ess, 1);     % Ici S contient la cat�gorie pour un essai donn�
        for U =1:cc(1,tlet,1).ncat
          S(:) =cc(2, tlet, U).ess(:)*U+S;
        end
      end
      for V =1:vg.ess
      	lestim ='-';
      	if vg.niveau
          lecat =0;
          for U =1:cc(1,vg.defniv,1).ncat
            if cc(2,vg.defniv,U).ess(V)
              lecat =U;
              break;
            end
          end
          if tlet
            if tlet == vg.defniv
              lestim ='';
            else
              lestim =[cc(2,tlet,S(V)).nom '-'];
            end
            if lecat
              lestim =[lestim cc(2,vg.defniv,lecat).nom];
            end
          else
            if vg.nst & thisObj.Hdchnl.numstim(V) & thisObj.Hdchnl.numstim(V) <= vg.nst
          	  lestim =[strtrim(vg.nomstim{thisObj.Hdchnl.numstim(V)}) '-'];
            end
            if lecat
              lestim =[lestim cc(2,vg.defniv,lecat).nom];
            end
          end
        else
          % Pas de niveaux, on v�rifie si on a des stimulus (avec vg.nst)
       	  if vg.nst & thisObj.Hdchnl.numstim(V) & thisObj.Hdchnl.numstim(V) <= vg.nst
        	lestim =[strtrim(vg.nomstim{thisObj.Hdchnl.numstim(V)}) ' -'];
          end
      	end
        if V >99
          L{V} =[num2str(V) '- ' lestim];
        elseif V >9
          L{V} =[num2str(V) ' - ' lestim];
        else
          L{V} =[num2str(V) '  - ' lestim];
        end
      end
      vg.lesess =L;
    end

    %------------------------------
    % Reb�ti la variable vg.lescats
    % pour l'affichage des noms de cat�gorie
    %------------------------
    function lescats(thisObj)
      vg =thisObj.Vg;
      cc =thisObj.Catego;
      vg.lescats ={};
      for N =1:vg.niveau
        for C =1:cc.Dato(1,N,1).ncat
          vg.lescats{end+1} =[strtrim(cc.Dato(1,N,1).nom) '--' strtrim(cc.Dato(2,N,C).nom)];
        end
      end
    end

    %---------------------------------------------------------------
    % Suite au nouveau format de fichier Analyse, il �tait important
    % de faire attention de ne pas �craser par d�faut un fichier qui
    % �tait dans l'ancien format.
    %    entrada  -->  nom du fichier � v�rifier
    % Au Retour
    %    []       -->  mauvais format de fichier (pas un format Analyse)
    %    false    -->  ancien format d'Analyse
    %    true     -->  nouveau format
    %-------------------------------------------
    function COk =SondeFichier(thisObj, entrada)
      COk =[];
      % on v�rifie si on a au moins une variable vg
      chk00 =whos('-file', entrada, 'vg');
      % on v�rifie si il y a une variable hdchnl
      chk01 =whos('-file', entrada, 'hdchnl');
      % on v�rifie si il y a une variable dtchnl
      chk02 =whos('-file', entrada, 'dtchnl');
      if isempty(chk00) | isempty(chk01)
        % il manque au moins une des variables de base dans les deux formats
        return;
      elseif isempty(chk02)
        % il y a apparence du nouveau format
       	ss =load(entrada, 'hdchnl');
       	if ~isfield(ss.hdchnl, 'cindx')
          % fausse alerte, ce n'est pas le nouveau format non plus.
          return;
        end
        % il s'agit bien du nouveau format
      	COk =true;
      else
        % apparence d'un fichier analyse
       	ss =load(entrada, 'hdchnl');
       	if isfield(ss.hdchnl, 'cindx')
        	COk =true;
          return;
        end
        COk =false;
      end
    end

    %----------------------------------------------------
    % Lorsque l'on a un fichier � l'ancien format on doit
    % le transformer dans la nouvelle version pour pouvoir
    % l'utiliser.
    %   fI  -->  nom du fichier d'entr�e
    %   fO  -->  nom du fichier de sortie
    %   hwb -->  handle d'un waitbar
    %---------------------------------------------
    function TransformCanaux(thisObj, fI, fO, hwb)
      dtchnl2can(thisObj, fI, fO, hwb);
    end

    %----------------------------------------------------------
    % Fonction pour passer de l'ancienne version � la nouvelle.
    %   entrada   -->  est le nom du fichier
    %   hwb       -->  est un handle sur le waitbar actif
    %-----------------------------------------------------
    function salida =correction(thisObj, entrada, hwb)
      OA =CAnalyse.getInstance();
      if OA.OPG.matlab
        palabras ={'**************************************';...
                   '*  Votre fichier Analyse doit �tre   *';...
                   '*  converti. Vous DEVRIEZ Donner un  *';...
                   '*  nouveau nom afin de conserver     *';...
                   '*  intacte l''ancien fichier.        *';...
                   '*                                    *';...
                   '**************************************'};
      else
        palabras ={'**************************************';...
                   '*  Votre fichier Analyse doit etre   *';...
                   '*  converti. Vous DEVRIEZ Donner un  *';...
                   '*  nouveau nom afin de conserver     *';...
                   '*  intacte l''ancien fichier.        *';...
                   '*                                    *';...
                   '**************************************'};
      end
      lafig =gcf;
      etalors =CValet.fen3bton('Conseil avant conversion',palabras,'Renommer','�craser',lafig);
      if isempty(etalors)       % on quitte
      	salida =[];
        return;
      elseif etalors            % on renomme
        [fnom,pnom] =uiputfile('*.mat','','nouveau.mat');
        if ((length(fnom) == 1) & (fnom == 0)) | OA.isfichopen(fullfile(pnom,fnom))
          salida =[];
          return;
        end
        salida =fullfile(pnom,fnom);
        guardar =0;
      else                      % on �crase
        agarder =[tempname() '.mat'];
        movefile(entrada,agarder);
        salida =entrada;
        entrada =agarder;
        guardar =1;
      end
      thisObj.TransformCanaux(entrada, salida, hwb);
      if guardar
      	delete(entrada);
      end
    end

    %----------------------------------------
    % Convertir un fichier de l'ancien format
    %   entrada   -->  est le nom du fichier
    %   hwb       -->  est un handle sur le waitbar actif
    %---------------------------------------
    function converti(thisObj, entrada, hwb)
      salida =[tempname(pwd) '.mat'];
      movefile(entrada, salida, 'f');
      thisObj.TransformCanaux(salida, entrada, hwb);
      delete(salida);
    end

  end  %methods (Access =protected)
end  %classdef
