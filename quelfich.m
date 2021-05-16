%
% GUI pour demander quel fichier on ouvre
%
% Fonction quelfich
% Cr�ateur: MEK, f�vrier 2009
%
% VARARGIN{1} ={'*.ext','extension � ouvrir'}
% VARARGIN{2} =Titre de la fen�tre
% VARARGIN{3} =1 Si multiselect, autrement 0
%
% VARARGOUT{1} =Nom du fichier choisi (En ordre alphab�tique si MULTI)
% VARARGOUT{2} =Path du fichier choisi
% VARARGOUT{3} =1 r�ussit, 0 �chec
%
function varargout =quelfich(varargin)
  lenom =varargin{1};
  letit =varargin{2};
  multi =varargin{3};
  %--------------------------------------------------------------------------------
  try
    % Avec Octave, si une figure est 'modal' on ne peut utiliser uigetfile par-dessus
    test =findall('Type','figure' , 'WindowStyle','modal');
  catch fiou
    test =[];
  end
  if ~isempty(test)
    set(test, 'WindowStyle','normal');
  end
  %--------------------------------------------------------------------------------
  cual =0;
  if multi
  	[fname,pname,cual] =uigetfile(lenom,letit,'MultiSelect','on');
    if cual & isdir(pname)
      cd(pname);
      if iscell(fname)
        fname =sort(fname);
      else
        fname ={fname};
      end
    end
  else
  	[fname,pname] =uigetfile(lenom,letit);
    if pname & isdir(pname)
      cd(pname);
      cual =1;
    end
  end
  %--------------------------------------------------------------------------------
  % On r�-�tabli les m�mes conditions que l'on avait � l'entr�e de cette fonction
  if ~isempty(test)
    set(test, 'WindowStyle','modal');
  end
  %--------------------------------------------------------------------------------
  varargout{1} =fname;
  varargout{2} =pname;
  varargout{3} =cual;
end
