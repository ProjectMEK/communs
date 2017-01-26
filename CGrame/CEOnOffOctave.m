%
% En passant à Octave, les Énumération ne sont pas supportées
% Temporairement, nous utiliserons ces classes pour contourner cette lacune.
%
classdef CEOnOffOctave < CETypeLogical

  %--------------------------------------------------------------
  % Comme on a pas d'énumération, on aura une classe "ordinaire"
  % avec des propriétés.
  %--------------------------------------------------------------
  properties (Constant)
    off =false;
    on =true;
  end

  %-------------------------------------
  methods (Access =private)

    %-------------------------------
    % CONSTRUCTOR
    %-------------------------------
    function tO = CEOnOffOctave(VAL)
      try
        tO.setList({'off','on'});
        tO.setPpa('CEOnOffOctave');
        tO.init(VAL);
      catch U
      	rethrow(U);
      end
    end
  end

  %-------------------------------------
  methods (Static)

    %------------------------------------------------------
    % Fonction membre pour créer l'instance de cette classe
    % en entrée on veut soit un objet de type CEOnOffOctave
    % soit une valeur logique.
    %------------------------------------------------------
    function tO = create(Vin)

      try

        % on vérifie si on a un objet de type CEOnOffOctave
      	monnom ='CEOnOffOctave';
        if strncmp(monnom, class(Vin), length(monnom))
          cur =Vin.char();
        else
          % ou logique
          cur =Vin;
        end
        tO =CEOnOffOctave(cur);
      catch U
        disp(U.identifier)
        disp(U.message)
        for V =1:length(U.stack)
          disp(U.stack(V))
        end
      end

    end

  end  % methods (Static)

end  % classdef
