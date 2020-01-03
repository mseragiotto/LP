-module(eval).
-export([eval/1, exp_s/1]).

%valutazione delle espressioni scritte in maniera estesa
eval({num, X})-> X;
eval({plus, Expr1, Expr2})->eval(Expr1)+eval(Expr2);
eval({minus, Expr1, Expr2})->eval(Expr1)-eval(Expr2);
eval({mul, Expr1, Expr2})->eval(Expr1)*eval(Expr2);
eval({dv, Expr1, Expr2})->eval(Expr1)/eval(Expr2);
eval({neg, Expr1})->-eval(Expr1).

%implementazione dello stack
pop([])->[];
pop([_|T])->T.

top([])->empty;
top([H|_])->H;
top(H)->H.

push(Elm, [])-> [Elm];
push(Elm, S)->[Elm|S].


exp_s(Str)->p(Str, [], []).

p([$(|T], Num, Op)->p(T, Num, Op); %parentesi aperta: proseguo la lettura
p([$+|T], Num, Op)->p(T, Num, push($+, Op)); 
p([$-|T], Num, Op)->p(T, Num, push($-, Op));
p([$*|T], Num, Op)->p(T, Num, push($*, Op));
p([$/|T], Num, Op)->p(T, Num, push($/, Op));
p([$~|T], Num, Op)->p(T, Num, push($~, Op));
p([$)|T], Num, Op)->extract(T, Num, Op);
p([], Num, _)->Num;
p([N|T], Num, Op)->p(T, push({num, list_to_integer([N])}, Num), Op).


extract(S, Num, [$+|Op])->p(S, push({plus, top(pop(Num)),top(Num)}, pop(pop(Num))), Op);
extract(S, Num, [$-|Op])->p(S, push({minus, top(pop(Num)), top(Num)}, pop(pop(Num))), Op);
extract(S, Num, [$*|Op])->p(S, push({mul, top(pop(Num)), top(Num)}, pop(pop(Num))), Op);
extract(S, Num, [$/|Op])->p(S, push({dv, top(pop(Num)), top(Num)}, pop(pop(Num))), Op);
extract(S, Num, [$~|Op])->p(S, push({neg, top(Num)}, pop(Num)), Op).