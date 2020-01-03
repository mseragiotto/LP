-module(ring).
%-compile(export_all).
-export([start/3]).
%modulo che crea un ring di N processi che inviano M messaggi nell'anello. Quando il 
%primo processo riceve indietro i messaggi, invia un messaggio di quit nel ring.

%funzione che invia gli M messaggi al primo processo dell'anello
send(_, _, 0, _) ->
	io:format("Processes creation done~n~n");
send(Pid, Message, M, L) ->
	%io:format("Server send to ~p msg n~p~n",[Pid,M]),
	Pid ! {self(), Message, 1, L},
	send(Pid, Message, M-1, L).

%loop di esecuzione dei processi
loop() ->
	receive
		{_, _, _, []} ->
			io:format("~p quitting...~n",[self()]);
		{Pid, Message, Num, L} -> 
			io:format("~p received ~p from ~p~n",[self(),Message,Pid]),
			Res = lists:member(self(),L),
			if 
				Res =:= false -> 
					%io:format("~p not in list~n",[self()]),
					lists:nth(1,L) ! {self(), quit, 1,  L--[lists:nth(1,L)]},
					io:format("~p quitting...~n",[self()]);
				true -> 
					if
						Num=:=length(L) ->
							%io:format("~p is the last~n",[self()]),
							lists:nth(1,L) ! {self(), Message, 1, L--[lists:nth(1,L)]},loop();
						true -> 
							lists:nth(Num+1,L) ! {self(), Message, Num+1, L},loop()
					end
			end
			
	end.

%creazione dei processi da parte del processo server
create(0, Message, M, L) ->
	send(lists:nth(1,L),Message,M,L);
create(N, Message, M, L) ->
	Pid = spawn(ring, loop, []),
	create(N-1, Message, M, L++[Pid]).
	
%avvio del programma
start(M, N, Message) ->
	create(N, Message, M, []).



