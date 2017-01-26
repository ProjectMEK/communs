%
% Classe utilis� dans Octave pour simuler les �num�rations comme dans Matlab.
% On aura ici la description pour une �num�ration "logique".
%
classdef CETypeLogical < CEGeneric

  methods

    function tO = CETypeLogical()
      tO.classe ='logical';
    end

    function init(tO, V)
      try

        % appel la fonction membre "init" de la classe h�rit�e.
        init@CEGeneric(tO, V);

        if isempty(tO.cur)
          for U =1:length(tO.list)
            if V && tO.(tO.list{U})
        	    tO.cur =tO.list{U};
        	    break;
            elseif ~V && ~tO.(tO.list{U})
              tO.cur =tO.list{U};
              break;
            end
          end
        end

      catch U
      	rethrow(U);
      end
    end

    function V = not(tO)
      V =~tO.value();
    end
    
  end
end
