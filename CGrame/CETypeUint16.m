%
% Classe CETypeUint16
%
% Développé pour palier au manque de la classe "ENUMERATION" dans Octave
% Auteur: MEK
%
classdef CETypeUint16 < CEGeneric

  methods
    function tO = CETypeUint16()
      tO.classe ='uint16';
    end

    %---------------------------------------
    % Initialisation de certaines properties
    % En entrée, V sera "char ou numeric"
    %---------------------------------------
    function init(tO, V)
      try
        init@CEGeneric(tO, V);
        if isempty(tO.cur)
          for U =1:length(tO.list)
            if V == tO.(tO.list{U})
              tO.cur =tO.list{U};
              break;
            end
          end
        end
      catch U
      	rethrow(U);
      end
    end
    
  end
end