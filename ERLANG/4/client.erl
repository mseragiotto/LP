-module(client).
-export([start/0, loop/0]).

loop() ->
	receive
		quit -> "Exit";
		
		{send, Message} -> 
			server ! Message,
			loop()
	end.

start() ->
	spawn(client, loop, []).