%
% Suite au changement majeur dans la structure des matrices de Analyse,
% on fait une vérification des différentes variables et on transforme la matrice
% DTCHNL(3D) en autant de matrice (2D) qu'il y a de canaux.
%
% EN ENTRÉE
%  obj         -->  objet de type CFichier ou par héritage CFichierAnalyse
%  entrada  -->  nom du fichier à transformer
%  salida    -->  nom du fichier de sauvegarde
%  ww        -->  handle d'un waitbar
%

function dtchnl2can(obj, entrada, salida, ww)
  % variable de controle de la création d'une waitbar
  delwb =false;
  if isempty(ww)
    delwb =true;
  	ww =waitbar(0.001, 'Conversion');
  end
  vernouv =obj.NouvelVersion;
  waitbar(0.01,ww,'Conversion du fichier Matlab, veuillez patienter');
  % on load le fichier à convertir
  pp =load(entrada);
  %-------------------------------
  % Les variables absentes sont crées vide
  %-------------------------------
  if ~isfield(pp, 'ptchnl')
  	pp.ptchnl =[];
  end
  if ~isfield(pp, 'tpchnl')
  	pp.tpchnl =[];
  end
  if ~isfield(pp, 'catego')
  	pp.catego =[];
  end
  % version du format matlab pour la sauvegarde
  txtver ='-V7.3';
  save(salida, '-Struct', 'pp', 'ptchnl',txtver);
  vg =pp.vg;
  vg.laver =vernouv;
  vg.otype =8;
  % on remplace les 'NAN' par zéro
  ss =isnan(pp.dtchnl(:));
  if length(ss)
    pp.dtchnl(ss) =0;
  end
  % total des étapes pour l'affichage dans la waitbar
  thermo =2*vg.ess*vg.nad;
  % transformation de hdchnl au nouveau format
  hdchnl =modifhdchnl(pp.hdchnl);
  vg.nomstim ={};
  hdchnl.numstim =zeros(1, vg.ess);
  for E =1:vg.ess
    pp.hdchnl(1,E).nomstim =strtrim(pp.hdchnl(1,E).nomstim);
    if isempty(pp.hdchnl(1,E).nomstim)
      continue;
    end
	  if isempty(vg.nomstim)
      vg.nomstim ={pp.hdchnl(1,E).nomstim};
      hdchnl.numstim(E) =1;
    else
      test =strcmpi(pp.hdchnl(1,E).nomstim, vg.nomstim);
      if sum(test)
        indice =find(test);
        hdchnl.numstim(E) =indice(1); %****** find(test, 1);
      else
        vg.nomstim{end+1} =pp.hdchnl(1,E).nomstim;
        hdchnl.numstim(E) =length(vg.nomstim);
      end
    end
  end
  ss =find(hdchnl.numstim == 0);
  if ~isempty(ss)
    vg.nomstim{end+1} ='Bidon';
    hdchnl.numstim(ss) =length(vg.nomstim);
  end
  vg.nst =length(vg.nomstim);
  for C =1:vg.nad
    hdchnl.adname{C} =strtrim(pp.hdchnl(C,1).adname);
    nsmpl =max(hdchnl.nsmpls(C,:));
    for E =1:vg.ess
	  hdchnl.max(C,E) =max(pp.dtchnl(1:pp.hdchnl(C,E).nsmpls, C, E));
	  hdchnl.min(C,E) =min(pp.dtchnl(1:pp.hdchnl(C,E).nsmpls, C, E));
  	  waitbar(((C-1)*vg.ess+E)/thermo,ww);
    end
    lacol =['c' num2str(C)];
	hdchnl.cindx{C} =lacol;
  	dato.(lacol) =permute(single(pp.dtchnl(1:nsmpl,C,:)),[1 3 2]);
    save(salida, '-STRUCT','dato',lacol,'-APPEND');
    dato.(lacol) =[];
  end
  pp =rmfield(pp, 'dtchnl');
  pp.hdchnl =hdchnl;
  pp.vg =vg;
  save(salida, '-Struct', 'pp','-APPEND');
  if delwb
    delete(ww);
  end
end
