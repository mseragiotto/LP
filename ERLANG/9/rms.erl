%master avvia N processi slave e invia messaggi.
%quando slave muore invia exit ma master è system process
%ogni messaggio inviato a slave genera risposta

-module(rms).
-compile(export_all).
%-export([start/1, to_slave/2]).


%avvio del master che avvia N slave
start() ->
	register(master, spawn(?MODULE, start_slave, [10])).

close() ->
	master ! die.

%creazione e salvataggio dei processi slave
start_slave(0) ->
	process_flag(trap_exit, true),
	loop_m();
start_slave(N) ->
	Pid = spawn(?MODULE, loop_s, []),
	link(Pid),
	put(N, Pid),
	start_slave(N-1).

%funzione per l'invio di messaggi da slave a slave
to_slave(Message, N) ->
	master ! {to_slave, {Message, N}}.

%loop di esecuzione dei processi slave
loop_s() ->
	receive
		{rev, Part} ->
			New = string:reverse(Part),
			master ! {self(), reversed, New};
		{master, die} ->
			master ! {self(), dying},
			exit("Die");
		{master, Message} ->
			io:format("Message: ~p~n",[Message]),
			loop_s()
	end.

%loop di esecuzione del processo master
loop_m() ->
	receive
		{result, Result} ->
			io:format("Result:~n~p~n",[Result]),
			loop_m();
		{reverse, S} ->
			long_reverse_string(S),
			loop_m();
		{From, reversed, Sub} ->
			io:format("master received substring ~p from ~p~n",[Sub, From]),
			[N] = get_keys(From),
			io:format("N=~p~n",[N]),
			New = N+10,
			put(New, Sub),
			loop_m();
		{to_slave, {Message, N}} ->
			get(N) ! {master, Message},
			io:format("Slave ~p got message ~p~n",[N, Message]),
			loop_m();
		{From, dying} ->
			N = get_keys(From),
			Pid = spawn(?MODULE, loop_s, []),
			link(Pid),
			put(N, Pid),
			io:format("master restarting dead slave~p",[N]),
			loop_m();
		die -> 
			io:format("Master died"),
			exit("DIE")
	end.

long_reverse_string(S) ->
	D = string:length(S) div 10,
	aux(S, 1, D, 0).

aux(_, 10, _, _) ->
	io:format("Substring sended!"),
	check_subs();
aux(S, N, D, Start) ->
	Part = string:slice(S,Start,D),
	Rest = string:slice(S, Start+D),
	get(N) ! {rev, Part},
	aux(Rest, N+1, D, Start+D).

check_subs() ->
	Check_l = [ get(X) || X <- [11,12,13,14,15,16,17,18,19,20]],
	Cond = lists:member(undefined, Check_l),
	if
		Cond =:= false ->
			Result = get(11)++get(12)++get(13)++get(14)++get(15)++get(16)++get(17)++get(18)++get(19)++get(20),
			master ! {result, Result};
		true -> false
	end.
