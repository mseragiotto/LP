-module(ring2).
-compile(export_all).
%-export([start/3]).

%funzione per inviare M messaggi
send(_, _, 0, L) ->
	lists:nth(1,L) ! {"M Message sent", 0};
send(Dest, Msg, M, L) ->
	Dest ! Msg,
	lists:nth(1,L) ! {"SEND MSG ACK", M},
	send(Dest, Msg, M-1, L).

%loop di esecuzione dei processi
loop() -> 
	receive
		{_, _, _, []} ->
			io:format("~p quitting...~n",[self()]);
		{Pid, Message, Num, L} ->
			lists:nth(1,L) ! {"~p received ~p from ~p~n", [self(),Message,Pid]},
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
			end;
		{_, Message, M, 1, L} ->
			send(lists:nth(1,L), {self(), Message, 1, L}, M, L),
			lists:nth(1,L) ! {"SPAWN ACK", L};
		{_, Message, M, N, L} ->
			NPid = spawn(?MODULE, loop, []),
			NPid ! {self(), Message, M, N-1, L++[NPid]},
			lists:nth(1,L) ! {"SPAWN ACK", L++[NPid]};
		{String, L} ->
			io:format("~p, ~p~n",[String,L])
	end.

%creazione dei successivi processi
create(N, Message, M) ->
	Pid = spawn(?MODULE, loop, []),
	Pid ! {self(), Message, M, N-1, [self(),Pid]},
	loop().
	
%avvio del programma
start(M, N, Message) ->
	create(N, Message, M).
