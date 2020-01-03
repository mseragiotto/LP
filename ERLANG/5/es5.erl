-module(es5). % counting dovrebbe essere
-export([start_server/0, start_client/1]).

server_run() -> receive 
		 {_, say, Statement} -> io:format("The server says: ~p\n", [Statement]);
		 {_, ask, Question} -> io:format("The server asks: ~p\n", [Question])
                end, server_run().

client_run(S) -> receive
	         {answer, A} -> io:format("~p\n", [A]);
	         {Service} -> S ! {self(), Service};
		 {Service, Parameters} -> S ! {self(), Service, Parameters}
	        end, client_run(S).

update([], Service, Prev) -> lists:append(Prev, [{Service, 1}]);
update([{Service, K} | TL], Service, Prev) -> lists:append(lists:append(Prev, [{Service, K + 1}]), TL);
update([E | TL], Service, Prev) -> update(TL, Service, lists:append(Prev, [E])).

update(L, Service) -> update(L, Service, []).

start_counting(L, S) -> receive
				{C, tot} -> LL = update(L, tot),
					    C ! {answer, LL},
					    start_counting(LL, S);
				{C, Service, Parameters} -> S ! {C, Service, Parameters}, 
							    start_counting(update(L, Service), S);
				_ -> io:format("Error\n"), 
			             exit(self())
			end.

% Chi avvia il server ottiene in realtà il Pid del counter, che fa da tramite
start_server() -> spawn(fun() -> start_counting([], spawn(fun() -> server_run() end)) end).
start_client(S) -> spawn(fun() -> client_run(S) end).
