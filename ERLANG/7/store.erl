%Distributed associative store su due nodi locali
%avviare due terminali e in entrambi chiamare la start dando in input i nomi dei due nodi.

-module(store).
-export([start/1, store/2, stop/1, lookup/1, loop/3]).

%registro il processo server con il nome del nodo locale
start(Processes) ->
	register(node(), spawn(node(),?MODULE, loop, [node(), Processes, []])).

%salvataggio valore 
store(Key, Value) ->
	{node(), node()} ! {store, node(), {Key, Value}}.

%Fermo il server
stop(Server)->
	{Server, Server} ! stop.

%recupero valori
lookup(Key) ->
	{node(), node()} ! {lookup, Key}.

%funzione che controlla sel un elemento è del tipo Tag, Value
is_member(Tag, Elm)->
	case Elm of
		{Tag, _} -> true;
		_->false
	end.

%loop di esecuzione: prende in input il nodo corrente, la lista di nodi e i dati salvati (inizialmente [])
loop(Self, Processes, Stored)->
	receive

		%salvataggio dati su nodo 
		{store, Curr, {Tag, Value}} -> 
			io:format("Registered~n"), 
			%invio update a tutti i nodi nella lista di processi
			[ {X, X} ! {update, {Tag, Value}} || X<-Processes, X=/=Curr ], 
			%aggiorno la lista di dati
			loop(Self, Processes, [{Tag,Value}|Stored]);

		{update, {Tag, Value}} -> 
			loop(Self, Processes, [{Tag,Value}|Stored]);	

		{lookup, Tag} -> 
			io:format("~p~n", [[X||X<-Stored, is_member(Tag, X)]]), 
			loop(Self, Processes, Stored);

		{print, Message} -> 
			io:format("~p~n", [Message]),
			loop(Self, Processes, Stored);

		stop -> 
			io:format("Server ~p terminated~n", [Self])
	end.