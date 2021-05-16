%
% En passant � Octave, les �num�ration ne sont pas encore support�es.
%
% Que ce soit pour Matlab ou Octave, on call la fonction CEOnOff()
% qui va appeler la classe Matlab (une �num�ration) en premier.
%
% Aussit�t que Octave aura impl�ment� les �num�ration, on pourra
% retirer ces artifice et garder la version Matlab seulement.
%
function sortir = CEFich(varargin)

  % Si on ne donne pas d'argument en entr�, le d�faut est: "1"
  if nargin
    entrer =varargin{1};
  else
    entrer =1;
  end

  try
    sortir =CEFichMatlab.create(entrer);
  catch M;
    sortir =CEFichOctave.create(entrer);
  end

end
