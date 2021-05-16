%
% isSyntaxBorneValid(t)
% (sera appel� par:  isSyntaxBornesValid())
%     param: t    'String' repr�sentant un point ou une valeur temporelle ou une expression
%
%     les valeurs de "t" possibles sont
%     0123456789+-*/() Pi Pf P1 P2...
%
%     On pourra avoir des expressions comme: P3+2  -> 2 sec apr�s le point 3
%
function resultat =isSyntaxBorneValid(t)
  resultat =false;
  %  ON ENL�VE TOUS LES BLANK
  pat ='\s+';
  tt =regexprep(t, pat, '');
  if ~isempty(tt)
    
    pat1 ='[\+/\*-][\+/\*-]';                 % ON V�RIFIE LES S�QUENCES ++ -- +- -+
    pat2 ='[^pif0123456789()\.\*/\+-]+';      % ON V�RIFIE LES CARACT�RES NON D�SIR�, un ou plus
    pat3 ='[\+/\*-]$';                        % ON V�RIFIE SI ON FINI AVEC -+*/
    pat4 ='^[/\*]';                           % ON V�RIFIE SI ON COMMENCE AVEC */

    if ~isempty(regexp(tt, pat1)) || ~isempty(regexpi(tt, pat2)) || ~isempty(regexp(tt, pat3)) || ~isempty(regexp(tt, pat4))
      % rien � faire
    else
      resultat =true;
    end

  end
end
