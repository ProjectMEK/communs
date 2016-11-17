% Laboratoire GRAME
% MEK - juin 2011
%
% Classe CDatoImport
% pour faire les importation d'un fichier Analyse � un autre
%
classdef CDatoImport < handle
  properties
    debcan;           % donne la concordance du premier canal import�
    fincan;           % donne ...           ... dernier ...
    modcan;           % Nb de canaux ajout�, sinon < 0
    debess;           % donne la concordance du premier essai import�
    finess;           % donne ...           ... dernier ...
    modess;           % Nb d'essai ajout�, sinon < 0
    f0nad;            % donne le nombre de canal du fichier actif avant modif
    f1nad;            % donne ...                       ... import� ...
    f0ess;            % donne le nombre d'essai du fichier actif avant modif
    f1ess;            % donne ...                      ... import� ...
  end
end
