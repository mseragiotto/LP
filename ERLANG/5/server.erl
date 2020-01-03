-module(server).
-compile(export_all).
-record(index, {dummy1=0, dummy2=0, dummy3=0, tot=0}).

%loop iniziale per la prima chiamata di servizio
%il servizio restituisce l'indice delle chiamate 
%alla chiamata loop1()
loop() ->
	receive
		{Pid, dummy1} ->
			loop1(dummy1(Pid, 0));
		{Pid, dummy2} ->
			loop1(dummy2(Pid, 0));
		{Pid, dummy3} ->
			loop1(dummy3(Pid, 0));
		{Pid, tot} ->
			loop1(tot(Pid, 0))
	end.

%loop eseguito per ogni chiamata successiva
%aggiorna l'indice e lo utilizza per le 
%successive chiamate
loop1(I) ->
	receive
		{Pid, dummy1} ->
			loop1(dummy1(Pid, I));
		{Pid, dummy2} ->
			loop1(dummy2(Pid, I));
		{Pid, dummy3} ->
			loop1(dummy3(Pid, I));
		{Pid, tot} ->
			loop1(tot(Pid, I))
	end.

dummy1(Pid, 0) ->
	I = #index{dummy1=1},
	Pid ! ok,
	I;
dummy1(Pid, I) ->
	#index{dummy1=N} = I,
	I1 = I#index{dummy1=N+1},
	Pid ! ok,
	I1.

dummy2(Pid, 0) ->
	I = #index{dummy2=1},
	Pid ! ok,
	I;
dummy2(Pid, I) ->
	#index{dummy2=N} = I,
	I1 = I#index{dummy2=N+1},
	Pid ! ok,
	I1.

dummy3(Pid, 0) ->
	I = #index{dummy3=1},
	Pid ! ok,
	I;
dummy3(Pid, I) ->
	#index{dummy3=N} = I,
	I1 = I#index{dummy3=N+1},
	Pid ! ok,
	I1. 

tot(Pid, 0) ->
	I = #index{},
	Pid ! I;
tot(Pid, I) ->
	#index{tot=N} = I,
	I1 = I#index{tot=N+1},
	Pid ! I1.
