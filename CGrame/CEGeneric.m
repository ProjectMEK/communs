%
% Classe utilisé dans Octave pour simuler les énumérations comme dans Matlab.
% CEGeneric sera hérité par d'autres classes plus spécifique, ex: logical...
%
% Ici, la majorité des fonctions membres sont pour overloader celles existantes.
%
classdef CEGeneric < handle
  properties
    ppa ='';              % nom de la Classe Enum
    classe ='';           % nom de la classe des valeurs de l'énumération
    list ={};             % liste des propriétés de l'énumération
    cur =[];              % valeur de l'objet courant (string/char)
  end

  methods
    function init(tO, VAL)
      try
        if strncmpi('char', class(VAL), 4)
          if ismember(VAL, tO.list)
          	tO.cur =VAL;
          end
        end
      catch U;
      	rethrow(U);
      end

    end

    function disp(tO)
   	  mot =sprintf('%s, %s\n', tO.ppa, tO.cur);
   	  disp(mot);
    end

    % retournera l'ensemble de toutes les valeurs possibles
    % en Matlab on ferait: enumeration(CEFich(1))
    function M = octEnum(tO)
      N =length(tO.list);
      M(N) =0;
      for U =1:N
        M(U) =tO.(tO.list{U});
      end
    end

    % On retourne la valeur caractère/string de l'objet
    function txt = char(tO)
      txt =tO.cur;
    end

    % On retourne la valeur numérique de l'objet
    function V = value(tO)
      V =tO.(tO.cur);
    end

    %-------------------------------------------
    % Fonction "=="
    % 
    % K --> pourra être de la même nature que tO
    %       numérique ou caractère/string.
    %-------------------------------------------
    function V = eq(tO, K)

      switch class(K)
      case tO.ppa
      	V = (tO.value() == K.value());
      case {'double', 'single', 'uint16', 'uint8', 'int', 'logical'}
      	V = (tO.value() == K);
      case 'char'
        V = strncmpi(tO.char(), K, length(K));
      otherwise
        V =false;
      end

    end

    %-------------------------------------------
    % Fonction "+"
    % 
    % T --> pourra être de la même nature que tO
    %       ou numérique.
    %-------------------------------------------
    function V = plus(tO, T)
      if isa(T, tO.ppa)
        V =tO.value() + T.value();
      else
        V =tO.value() + T;
      end
    end

    function V = int8(tO)
      V =int8(tO.value());
    end

    function V = logical(tO)
      V =logical(tO.value());
    end

    function foo = getList(tO)
      foo =tO.list;
    end

  end

  methods (Access = protected)

    function setList(tO, L)
      tO.list =L;
    end

    function setPpa(tO, P)
      tO.ppa =P;
    end

    function setCur(tO, V)
      tO.cur =V;
    end
    
  end
end