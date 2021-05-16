%
% En passant à Octave, les Énumération ne sont pas encore supportées.
%
% Que ce soit pour Matlab ou Octave, on call la fonction CEOnOff()
% qui va appeler la classe Matlab (une Énumération) en premier.
%
% Aussitôt que Octave aura implémenté les énumération, on pourra
% retirer ces artifice et garder la version Matlab seulement.
%
function sortir = CEOnOff(varargin)

  % Si on ne donne pas d'argument en entré, le défaut est: "true"
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
