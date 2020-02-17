-module(controller).
-export([start/1]).

primes(N) when (N > 1) -> [X || X <- lists:seq(2,N), (length([Y || Y <- lists:seq(2, trunc(math:sqrt(X))), ((X rem Y) == 0)]) == 0)];
primes(_) -> [].

start(Range) ->
	register(controller, self()),
	P_list = primes(Range),
	[H|T] = P_list,
	register(first, spawn(sieve, generate_succ, [H,T,lists:last(P_list)])),
	loop().

loop() ->
	receive

		{print, pass, Div} ->
			%io:format("DEBUG - Msg pass to sieve ~p ~n", [Div]),
			loop();

		{print, new, Div} ->
			%io:format("DEBUG - Msg new to sieve ~p ~n", [Div]),
			loop();

		{new, N} -> 
			%io:format("DEBUG - Msg new to first sieve ~n"),
			io:format("You asked for: ~p~n",[N]),
			first ! {new, N},
			loop();

		{res, R} ->
			%io:format("DEBUG - N is prime: ~p ~n~n", [R]),
			{client, amora@matteo} ! {result, R},
			loop();

		{uncheckable, N} ->
			{client, amora@matteo} ! {uncheckable, N},
			loop();

		{quit} ->
			io:format("I'm closing ...~n~n")

	end.

%cambiare gli if con i case