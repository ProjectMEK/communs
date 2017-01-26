%
% En passant � Octave, les �num�ration ne sont pas encore support�es.
%
% Que ce soit pour Matlab ou Octave, on call la fonction CEOnOff()
% qui va appeler la classe Matlab en premier.
%
function sortir = CEOnOff(varargin)

  % Si on ne donne pas d'argument en entr�, le d�faut est: "true"
  if nargin
    entrer =varargin{1};
  else
    entrer =true;
  end

  try
    sortir =CEOnOffMatlab(entrer);
  catch M
    sortir =CEOnOffOctave.create(entrer);
  end

end