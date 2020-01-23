-module(bank).
-compile(export_all).

start() ->
	register(bank, self()),
	loop(5000).

loop(Balance) -> 
	receive

		{deposit, Money, AtmID, LocalCount, GlobalCount} ->
			io:format("I got a deposit of ~p€ from ATM ~p (local msg ~p global msg ~p)~n", [Money, AtmID, LocalCount, GlobalCount]),
			loop(Balance+Money);

		{withdraw, Money, AtmID, LocalCount, GlobalCount} ->
			io:format("I got a withdraw of ~p€ from ATM ~p (local msg ~p global msg ~p)~n", [Money, AtmID, LocalCount, GlobalCount]),
			loop(Balance-Money);

		{balance, Pid, AtmID, LocalCount, GlobalCount} ->
			io:format("I got a balance request ATM ~p (local msg ~p global msg ~p)~n", [AtmID, LocalCount, GlobalCount]),
			Pid ! {balanceResponse, Balance},
			loop(Balance)

		
	end.