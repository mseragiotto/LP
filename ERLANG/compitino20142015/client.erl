-module(client).
-export([is_prime/1, close/0]).

is_prime(N) ->
	Cond = whereis(client) == self(),
	if
		Cond == false ->
			register(client, self());
		Cond == true ->
			true
	end,
	{controller, sif@matteo} ! {new, N},
	loop(N).

loop(N) ->
	receive

		{result, R} ->
			io:format("\"is ~p prime? ~p\"~n", [N,R]);

		{uncheckable, N} ->
			io:format("\"~p is uncheckable, too big value.\"~n", [N])

	end.

close() ->
	{controller, sif@matteo} ! {quit},
	io:format("\"The service is closed!!!\"").