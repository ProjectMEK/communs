%
%  En entr� on a besoin de la variable d'ent�te hdchnl et le nom exacte du canal
%
%           nomvar = nom_canal2nom_variable(hdchnl, nom)
%  [nomvar, index] = nom_canal2nom_variable(hdchnl, nom)
%
%  En sortie on aura la variable correspondante qui contient les datas
%  ou [] si le nom n'existe pas.
%
%  Le deuxi�me param en sortie est le num�ro du canal
%-------------------------------------------------------------------------------
function varargout = nom_canal2nom_variable(hdchnl, nom)
  nomvar = [];
  [a, index] = ismember(nom, hdchnl.adname);
  if index
    nomvar = hdchnl.cindx{index};
  end
  varargout{1} = nomvar;
  if nargout > 1
    varargout{2} = index;
  end
end
