%
% classdef CParamJournal < handle
%
% METHODS
%
classdef CParamJournal < handle

  properties
      fig =[];
      lesmots =[];
  end   %properties

  methods

    function initLesmots(tO)
      tO.lesmots ={['Début de la journalisation: ' datestr(now)]};
      tO.lesmots{end+1} ='------------------------------------------------------------------';
    end

  end

end