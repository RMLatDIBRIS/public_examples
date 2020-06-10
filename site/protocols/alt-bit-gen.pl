:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, msg_et(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"msg", args:[Ty]}).
match(_event, ack_et(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"ack", args:[Ty]}).
match(_event, msg_et) :- match(_event, msg_et(_)).
match(_event, ack_et) :- match(_event, ack_et(_)).
match(_event, type_et(Ty)) :- match(_event, msg_et(Ty)).
match(_event, type_et(Ty)) :- match(_event, ack_et(Ty)).
match(_event, relevant_et) :- match(_event, type_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>(((msg_et>>(msg_et(1)*app(BS, [1])));1)/\MA));1)),
	(BS=gen([ty], var(ty2, (msg_et(var(ty2))*guarded((var(ty2) =:= (var(ty) + 1)), app(BS, [var(ty2)]), app(MM, [2, var(ty)])))))),
	(MM=gen([ty, mx], (msg_et(var(ty))*guarded((var(ty) >= var(mx)), app(MM, [1, var(mx)]), app(MM, [(var(ty) + 1), var(mx)]))))),
	(MA=var(ty, (msg_et(var(ty))*(((type_et(var(ty))>>(ack_et(var(ty))*1));1)/\(ack_et(var(ty))|MA))))).
