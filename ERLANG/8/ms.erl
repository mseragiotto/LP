%master avvia N processi slave e invia messaggi.
%quando slave muore invia exit ma master è system process
%ogni messaggio inviato a slave genera risposta

-module(ms).
-compile(export_all).
%-export([start/1, to_slave/2]).


%avvio del master che avvia N slave
start(N) ->
	register(master, spawn(?MODULE, start_slave, [N])).

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
			loop_m()
	end.