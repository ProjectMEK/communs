%
% Classe pour traiter les erreurs rencontrées
%
classdef CQueEsEsteError

  methods (Static)

    %---------------------------------------------------
    % On formatte les messages d'erreur pour l'affichage
    %--------------------
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

      %-------------------------------------------------------------------------
      % On va lire l'instance des paramètres globaux. (Globaux pour toutes les
      % application qui utilisent les classes du dossier "communs/CGrame")
      %-------------------------------------------------------------------------
      PG =CParamGlobal.getInstance();
      dispError =PG.getDispError();

      if dispError == 0
        % l'usager a choisi de ne pas afficher les messages d'erreurs
        val =[];
      else

        % l'usager a choisi d'afficher les messages d'erreurs
        if isa(e, 'MException')
          val =CQueEsEsteError.esoEsUnaClass(e, dispError);
        elseif isa(e, 'struct')
          val =CQueEsEsteError.esoEsUnaStruct(e, dispError);
        elseif isa(e, 'char')
          val =e;
        elseif isa(e, 'numeric')
          val =num2str(e);
        else
          val ='?';
        end
      end
    end

    %-------------------------------------
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

    %--------------------------------------------------------
    % Lorsque le message d'erreur n'est pas contenu dans un
    % Objet de la classe MException.
    % Me est une structure qui reflète MException
    % forme  nous indique quoi afficher (voir CParamGlobal.m)
    %--------------------------------------------------------
    function val =esoEsUnaStruct(Me, forme)
      val =[];
      lemess =[];
      lident =[];

      if isfield(Me, 'message')
        lemess =Me.message;
      end
      if isfield(Me, 'identifier')
        lident =Me.identifier;
      end

      % on va bâtir le message à afficher petit à petit en fonction
      % des demandes spécifiées dans CParamGlobal() et des champs disponibles

      switch forme

      case 3
        val =[lident ': ' lemess];

      case 2
        val =lemess;

      case 1
        val ={[lident ': ' lemess]};
        if isfield(Me, 'stack')
          for U =1:length(Me.stack)
          val{end+1} =[Me.stack(U).name ' ligne: ' num2str(Me.stack(U).line)];
          end
        end

      end

    end

    %--------------------
    function dispOct(MOO)
      %-------------------------------------------------------------------------
      % On va lire l'instance des paramètres globaux. (Globaux pour toutes les
      % application qui utilisent les classes du dossier "communs/CGrame")
      %-------------------------------------------------------------------------
      PG =CParamGlobal.getInstance();
      if ~PG.getMatlab()
        S =findstr(MOO.stack(1).file, filesep());
        if length(S) > 2
          fnom =MOO.stack(1).file(S(end-2)+1:end);
        end
        lesMots =sprintf('[%s] %s ligne: %i', fnom, MOO.stack(1).name, MOO.stack(1).line);
        disp(lesMots);
      end
    end

  end % methods
end % Class
