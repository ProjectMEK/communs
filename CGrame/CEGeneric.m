%
% Classe utilis� dans Octave pour simuler les �num�rations comme dans Matlab.
% CEGeneric sera h�rit� par d'autres classes plus sp�cifique, ex: logical...
%
% Ici, la majorit� des fonctions membres sont pour overloader celles existantes.
%
classdef CEGeneric < handle
  properties
    ppa ='';              % nom de la Classe Enum
    classe ='';           % nom de la classe des valeurs de l'�num�ration
    list ={};             % liste des propri�t�s de l'�num�ration
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

    % On retourne la valeur caract�re/string de l'objet
    function txt = char(tO)
      txt =tO.cur;
    end

    % On retourne la valeur num�rique de l'objet
    function V = value(tO)
      V =tO.(tO.cur);
    end

    %-------------------------------------------
    % Fonction "=="
    % 
    % K --> pourra �tre de la m�me nature que tO
    %       num�rique ou caract�re/string.
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
    % T --> pourra �tre de la m�me nature que tO
    %       ou num�rique.
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