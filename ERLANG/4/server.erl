-module(server).
%-compile(export_all).
%cd('/media/matteo/Dati/Desktop/CORSI/LP/erlang/4').
%cover:compile_directory().
-export([start/0,loop/0]).

loop() ->
	receive
		quit -> exit("AHAH");
		{connect, Pid} ->
			link(whereis(Pid));
		Message -> Message, 
		loop()
	end.

start() ->
	spawn(server, loop, []).