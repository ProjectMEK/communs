%
% Classe pour traiter les erreurs rencontrées
%
classdef CQueEsEsteError

  methods (Static)

    %---------------
    function disp(erreur)

      % On commence par décortiquer la variable "erreur"
      v =CQueEsEsteError.queEsEso(erreur);

      % si le résultat est non vide alors on l'affiche
      if ~isempty(v)
        disp(v);
      end
    end

    %------------------------
    function val =queEsEso(e)

      % On va lire l'instance des paramètres globaux. (Globaux pour toutes les
      % application qui utilisent les classes du dossier "communs/CGrame")
      PG =CParamGlobal.getInstance();
      dispError =PG.getDispError();

      if dispError == 0
        % l'usager a choisi de ne pas afficher les messages d'erreurs
        val =[];
      else
        if isa(e, 'MException')
          val =CQueEsEsteError.esoEsUnaClass(e, dispError);
        elseif isa(e, 'char')
          val =e;
        elseif isa(e, 'numeric')
          val =num2str(e);
        else
          val ='?';
        end
      end
    end

    %-------------------------------
    function val =esoEsUnaClass(Me, forme)
      switch forme
      case 3
        val =[Me.identifier ': ' Me.message];
      case 2
        val =Me.message;
      case 1
        val =[Me.identifier ': ' Me.message];
        if ~isempty(Me.stack)
          for U =1:length(Me.stack)
            val =sprintf('%s\n%s ligne: %i', val, Me.stack(U).name, Me.stack(U).line);
          end
        end
      end
    end

  end % methods
end % Class
