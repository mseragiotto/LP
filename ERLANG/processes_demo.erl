-module(processes_demo).
-export([start/2, loop/2]).

start(N,A) -> spawn (processes_demo, loop, [N,A]).

loop(0,A) -> io:format("~p(~p) ~p~n", [A, self(), stops]);
loop(N,A) -> io:format("~p(~p) ~p~n", [A, self(), N]), loop(N-1,A).