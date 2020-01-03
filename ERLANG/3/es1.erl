-module(es1).
-export([is_palindrome/1, is_an_anagram/2, factors/1]).%, is_proper/1]).

%tramite regex elimino i caratteri inutili, copio e inverto la stringa
% e infine verifico che siano uguale
is_palindrome(S) ->
	S_clean = string:casefold(re:replace(S, "\\,|\\;|\\.|\\:|\\-|\\_|\\?|\\!|\\s", "", [{return, list}, global])),
	S_reverse = string:reverse(S_clean),
	case S_clean of 
		S_reverse -> true;
		_Else -> false
	end.

%funzione che esegue tutte le permutazioni di una stringa
perms([]) -> [[]];
perms(Word) -> [ [H|Rest] || H <- Word, Rest <- perms(Word -- [H]) ].

%creo una lista di risultati del controllo su ogni stringa nella lista con la lista
%di permutazioni: se c'è almeno un true, restituisco true.
check_anagram(S, [H]) -> [lists:member(H,perms(S))];
check_anagram(S, [H|T]) -> [lists:member(H,perms(S))|check_anagram(S,T)].

%qui controllo se esiste un true nella lista risultante
is_an_anagram(S, L) -> lists:member(true,check_anagram(S,L)).

%funzione che restituisce tutti i numeri primi fino alla cifra in input
primes(N) when N > 1 -> 
	[X || X <- lists:seq(2,N), (length([Y || Y <- lists:seq(2, trunc(math:sqrt(X))), ((X rem Y) == 0)]) == 0)];
primes(_) -> [].

%quando l'input è intero e maggiore di zero, restituisco la decomposizione
factors(N) when is_integer(N), (N > 0) -> lists:reverse(decomp(N,[],2)).

%se il quadrato del divisore è maggiore del numero, inserisco il numero stesso
%tra i fattori primi.
decomp(N,R,I) when I*I > N -> [N|R];
%se I è divisore di N, salvo I come fattore e calcolo la decomposizione in fattori
%del risultato della divisione.
decomp(N,R,I) when (N rem I) =:= 0 -> decomp(N div I, [I|R],I);
%se I non è divisore di N, lo aumento a 3 oppure di due in due (num primi)
decomp(N,R,2) -> decomp(N,R,3);
decomp(N,R,I) -> decomp(N,R,I+2).

%is_proper(N) -> 