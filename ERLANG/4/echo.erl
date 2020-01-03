-module(echo).
-compile(export_all).
%-import(server, [start/0]).

%avvio e registrazione processo server
start_server() ->
	Pid = server:start(),
	register(server, Pid),
	ok.

%avvio e registrazione processo client
start_client() ->
	Pid = client:start(),
	register(client, Pid),
	ok.

%client invia messaggio al server
client_send(Msg) ->
	client ! {send, Msg},
	ok.

%il server crea link con client (non funziona!)
connect() ->
	server ! {connect, client},
	ok.

%server stampa il messaggio inviato
print(Term) ->
	server ! Term,
	ok.

%stampa del pid del processo registrato
print_pid(Pid) ->
	whereis(Pid).

%invio segnale di stop che forza exit server
stop() -> 
	server ! quit,
	ok.
%in teoria la exit con server linkato a client dovrebbe far crashare client
