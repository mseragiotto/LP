-module(atm_proc).
-compile(export_all).

hello(N, AtmProcess) -> 
	{dispatcher, sif@matteo} ! {hello, N, self()},
	loop(AtmProcess).

loop(AtmProcess) ->
	receive

		{deposit, Dest, AtmID, Money} ->
			{dispatcher, Dest} ! {deposit, AtmID, Money},
			loop(AtmProcess);

		{withdraw, Dest, AtmID, Money} ->
			{dispatcher, Dest} ! {withdraw, AtmID, Money},
			loop(AtmProcess);

		{balance, Dest, AtmID} ->	
			{dispatcher, Dest} ! {balance, AtmID},
			loop(AtmProcess);

		{balanceResponse, Balance} ->
			AtmProcess ! {balanceResponse, Balance},
			loop(AtmProcess)

	end.
