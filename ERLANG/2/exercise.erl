%Write a function called my_tuple_to_list(T)
-module(exercise).
-export([my_tuple_to_list/1, aux/3]).

my_tuple_to_list({}) -> [];
my_tuple_to_list(T) -> aux(T,1,tuple_size(T)).

aux(T,Pos,Size) -> [element(Pos,T)|aux(T,Pos+1,Size)];
aux(T,Size,Size) -> element(Size,T).
