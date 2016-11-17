%
% classdef CBasePourFigure < handle
%
% METHODS
%       delete(tO)                 % DESTRUCTOR
%       figFocus(tO)
%       setFigModal(tO)
%       setFigNormal(tO)
%
classdef CBasePourFigure < handle
  %---------
  properties
    fig =[];          % handle de la figure
  end
  %------
  methods
    %-------
    function delete(tO)                 % DESTRUCTOR
      if ~isempty(tO.fig) & ishandle(tO.fig)
        delete(tO.fig);
      end
    end
    %_____________________________________________
    % On ram�ne le focus sur la figure principale
    %-------
    function figFocus(tO)
      figure(tO.fig);
    end
    %_____________________________________________
    % On garde le focus 'gel�' sur la fen�tre
    %-------
    function setFigModal(tO)
      set(tO.fig, 'WindowStyle','modal');
    end
    %_____________________________________________
    % On 'd�g�le' sur la fen�tre
    %-------
    function setFigNormal(tO)
      set(tO.fig, 'WindowStyle','normal');
    end
  end
end
