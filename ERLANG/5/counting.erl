-module(counting).
-compile(export_all).

%modulo che avvia il server e permette di chiamare i suoi servizi
start() ->
	register(server, spawn(server, loop, [])).

service(Name) ->
	server ! {self(),Name},
	receive
		ok -> ok;
		L -> L
	end.