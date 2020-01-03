-module(accumulate).
-export([perform/2]).
-import(mfr, [map/2, filter/2, reduce/2]).

perform(sum, L) -> reduce((fun(X,Y) -> X+Y end), L);
perform(sub, L) -> reduce((fun(X,Y) -> X-Y end), L);
perform(mul, L) -> reduce((fun(X,Y) -> X*Y end), L);
perform(divi, L) -> reduce((fun(X,Y) -> X div Y end), L).
