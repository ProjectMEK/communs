%
% classe CAideGUI
%
% pour permettre de rendre l'écriture des mfiles un peu plus compacte
% lors de la création des GUI...
%
% Ex.1  foo =CAideGUI();
%       foo.posx =25;
%       foo.posy =50;
%       foo.large =250;
%       foo.haut =555;
%       fig =figure('position',foo.pos)
%
% Ex.2  foo =CAideGUI(25,50,250,555);
%       fig =figure('position',foo.pos)
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

    %-------------------------------------
    % CONSTRUCTOR
    % En entrée on peut donner la position
    %   CAideGUI(posx, posy, large, haut)
    %-------------------------------------
    function tO = CAideGUI(varargin)
      if nargin > 3
        tO.haut =varargin{4};
      end
      if nargin > 2
        tO.large =varargin{3};
      end
      if nargin > 1
        tO.posy =varargin{2};
      end
      if nargin > 0
        tO.posx =varargin{1};
      end
      tO.pos =[tO.posx tO.posy tO.large tO.haut];
    end


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