-module(mfr).
-export([map/2,filter/2,reduce/2]).

map(_, []) -> [];
map(F, [H|TL]) -> [F(H)|map(F,TL)].

filter(_, []) -> [];
filter(P, [H|TL]) -> filter(P(H), P, H, TL).
filter(true, P, H, L) -> [H|filter(P, L)];
filter(false, P, _, L) -> filter(P, L).

reduce(F, [H|TL]) -> reduce(F, H, TL).
reduce(_, Q, []) -> Q;
reduce(F, Q, [H|TL]) -> reduce(F, F(Q,H), TL).