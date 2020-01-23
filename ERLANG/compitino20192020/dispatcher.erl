-module(dispatcher).
-compile(export_all).
%-export([]).

start(BankAddr) ->
	register(dispatcher, self()),
	loop(BankAddr, 0, #{}, #{}).
	%register(dispatcher, spawn(?MODULE, loop, [BankAddr, 0, #{}])).

loop(BankAddr, GlobalCount, LocalCount, AtmDB) -> 
	receive
		{hello, ID, From} ->  NewAtmDB = maps:put(ID, From, AtmDB),
		loop(BankAddr, GlobalCount, LocalCount, NewAtmDB);

		{deposit, AtmID, Money} ->
			Condition = maps:is_key(AtmID, LocalCount),
			if 
				Condition == true -> 
					NewLocalCount = maps:put(AtmID, (maps:get(AtmID, LocalCount)+1), LocalCount);

				Condition == false -> 
					NewLocalCount = maps:put(AtmID, 0, LocalCount)			
			end,
			io:format("I'm MM~p and I dealt with MSG #~p~n", [AtmID, maps:get(AtmID, NewLocalCount)]),
			{bank, BankAddr} ! {deposit, Money, AtmID, maps:get(AtmID, NewLocalCount), GlobalCount},
			loop(BankAddr, GlobalCount+1, NewLocalCount, AtmDB);

		{withdraw, AtmID, Money} ->
			Condition = maps:is_key(AtmID, LocalCount),
			if 
				Condition == true -> 
					NewLocalCount = maps:put(AtmID, (maps:get(AtmID, LocalCount)+1), LocalCount);

				Condition == false -> 
					NewLocalCount = maps:put(AtmID, 0, LocalCount)			
			end,
			io:format("I'm MM~p and I dealt with MSG #~p~n", [AtmID, maps:get(AtmID, NewLocalCount)]),
			{bank, BankAddr} ! {withdraw, Money, AtmID, maps:get(AtmID, NewLocalCount), GlobalCount},
			loop(BankAddr, GlobalCount+1, NewLocalCount, AtmDB);
		
		{balance, AtmID} -> 
			Condition = maps:is_key(AtmID, LocalCount),
			if 
				Condition == true -> 
					NewLocalCount = maps:put(AtmID, (maps:get(AtmID, LocalCount)+1), LocalCount);

				Condition == false -> 
					NewLocalCount = maps:put(AtmID, 0, LocalCount)			
			end,
			io:format("I'm MM~p and I dealt with MSG #~p~n", [AtmID, maps:get(AtmID, NewLocalCount)]),
			{bank, BankAddr} ! {balance, maps:get(AtmID, AtmDB), AtmID, maps:get(AtmID, NewLocalCount), GlobalCount},
			loop(BankAddr, GlobalCount+1, NewLocalCount, AtmDB)
	end.
