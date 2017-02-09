classdef CETypeUint16 < CEGeneric

  methods
    function tO = CETypeUint16()
      tO.classe ='uint16';
    end

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