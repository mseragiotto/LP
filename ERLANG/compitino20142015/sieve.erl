-module(sieve).
-export([generate_succ/3]).

generate_succ(Div,[], Last) ->
	loop(Div, first, Last);
generate_succ(Div,[H|T], Last) ->
	put(H, spawn(?MODULE, generate_succ, [H,T, Last])),
	loop(Div,get(H),Last).

loop(Div, Succ, Last) ->
	receive
		{pass, N} -> 
			IsLimit = math:sqrt(N) >= Last,
			if
				IsLimit == true ->
					controller ! {uncheckable, N},
					loop(Div, Succ, Last);

				IsLimit == false ->
					true
					
			end,
			IsPrime = N == Div,
			Cond = (N rem Div) =/= 0,
			if 
				IsPrime == true ->
					first ! {res, true},
					loop(Div, Succ, Last);

				IsPrime == false -> 
					if
						Cond == true ->
							Succ ! {pass, N};

						Cond == false ->	
							first ! {res, false},
							loop(Div, Succ, Last)
					end
			end,
			controller ! {print, pass, Div},
			loop(Div, Succ, Last);

		{new, N} ->
			Cond = ((N rem Div) =/= 0) and (self() == whereis(first)), 
			if 
				Cond == true ->
					Succ ! {pass, N};

				Cond == false ->	
					controller ! {res, false},
					loop(Div, Succ, Last)
			end,
			controller ! {print, new, Div},
			loop(Div, Succ, Last);

		{res, R} ->
			controller ! {res, R},
			loop(Div, Succ, Last)

	end.

	