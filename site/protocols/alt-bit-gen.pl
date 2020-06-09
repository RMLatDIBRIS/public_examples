:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, msg(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"msg", args:[Ty]}).
match(_event, ack(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"ack", args:[Ty]}).
match(_event, msg) :- match(_event, msg(_)).
match(_event, ack) :- match(_event, ack(_)).
match(_event, type(Ty)) :- match(_event, msg(Ty)).
match(_event, type(Ty)) :- match(_event, ack(Ty)).
match(_event, relevant) :- match(_event, type(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>(((msg>>(msg(1)*app(BS, [1])));1)/\MA));1)),
	(BS=gen([ty], var(ty2, (msg(var(ty2))*guarded((var(ty2) =:= (var(ty) + 1)), app(BS, [var(ty2)]), app(MM, [2, var(ty)])))))),
	(MM=gen([ty, mx], (msg(var(ty))*guarded((var(ty) >= var(mx)), app(MM, [1, var(mx)]), app(MM, [(var(ty) + 1), var(mx)]))))),
	(MA=var(ty, (msg(var(ty))*(((type(var(ty))>>(ack(var(ty))*1));1)/\(ack(var(ty))|MA))))).
