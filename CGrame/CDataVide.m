%
% Class CDataVide
%
% Objet utile lorsque l'on a � passer des datas d'une fonction
% � l'autre sans vouloir jouer avec des variables "global".
%
classdef CDataVide < handle
  %---------
  properties
    D;            % variable vide qui pourra �tre utilis� au besoin
    cur;
  end
end