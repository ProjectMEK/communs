%
% Fonction pour simuler la classe MException de matlab
%
% Retournera une structure "à la MException"
%
function foo =Oct_MException(leIDENTIFIER,leMESSAGE,leSTACK)

  foo =struct('message',[],'identifier',[]);

  if exist('leIDENTIFIER','var')
    foo.identifier =leIDENTIFIER;
  end

  if exist('leMESSAGE','var')
    foo.message =leMESSAGE;
  end

  if exist('leSTACK','var')
    foo.stack =leSTACK;
  else
    % foo.stack =struct('file',[],'name',[],'line',[],'column',[],'scope',[],'context',[]);
  end

end
