-module(comprehensions).
-export([squared_int/1, intersect/2, symmetric_difference/2]).
%-compile(export_all).
%cd('/media/matteo/Dati/Desktop/CORSI/LP/erlang/6').

%quadrato degli interi presenti in una lista mista

squared_int(L) ->
	[ X*X || X <- L, integer(X)].

%intersezione tra due liste

intersect(L1,L2) ->
	[ X || Y <- L1, X <- L2, X=:=Y].

%sottrazione tra due liste

symmetric_difference(L1,L2) ->
	[ X || X <- L1, not lists:member(X,L2)]++[Y || Y <- L2, not lists:member(Y, L1)].