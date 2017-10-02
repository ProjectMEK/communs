%
% classe CAideGUI
%
% pour permettre de rendre l'écriture des mfiles un peu plus compacte
% lors de la création des GUI...
%
% MEK
% août 2017
%
classdef CAideGUI < handle

  properties  % (SetAccess = private)
    pos = [0.0 0.0 0.0 0.0];
    posx = 0.0;
    posy = 0.0;
    large = 0.0;
    haut = 0.0;
  end

  methods

    function set.posx(tO,X)
      tO.posx =X;
      tO.pos(1) =X;
    end

    function set.posy(tO,Y)
      tO.posy =Y;
      tO.pos(2) =Y;
    end

    function set.large(tO,L)
      tO.large =L;
      tO.pos(3) =L;
    end

    function set.haut(tO,H)
      tO.haut =H;
      tO.pos(4) =H;
    end

  end

end