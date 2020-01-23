-module(atm).
-compile(export_all).
%-export([start/1, deposit/3, withdraw/3, balance/2]).

start(N) -> 
	Cond = get(N),
	if  
		Cond == undefined -> 
			put(N, spawn(atm_proc, hello, [N, self()]));
		Cond =/= undefined ->
			io:format("Error, ATM already exists~n")
	end.


deposit(Dest, AtmID, Money) ->
	get(AtmID) ! {deposit, Dest, AtmID, Money}.

withdraw(Dest, AtmID, Money) ->
	get(AtmID) ! {withdraw, Dest, AtmID, Money}.

balance(Dest, AtmID) ->
	get(AtmID) ! {balance, Dest, AtmID},
	receive
		{balanceResponse, Balance} -> 
			io:format("Currently, the balance is ~p€.~n", [Balance])
	end.