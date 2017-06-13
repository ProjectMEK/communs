%
% Classe CFinfo
%
% Informations sur le fichier lui même
%

classdef CFinfo < handle
  properties
    prenom ='';   % dossier de travail (path)
    finame ='';   % nom du fichier en entrée
    foname ='';   % nom du fichier en sortie...appelé à disparaître
    fich =[];     % est appelé à disparaître
    fitmp =[];    % nom du fichier temporaire de travail
  end

  methods

    %-------------------
    % DESTRUCTOR
    %-------------------
    function delete(obj)
      if exist(obj.fitmp) == 2
    	  delete(obj.fitmp);
      end
    end

  end % method
end % classdef
