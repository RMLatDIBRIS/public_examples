:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, msg_et(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"msg", args:[Ty]}).
match(_event, relevant_et) :- match(_event, msg_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Msg=gen([inf, sup], guarded((var(inf) =< var(sup)), (msg_et(var(inf))*app(Msg, [(var(inf) + 1), var(sup)])), eps))),
	(Main=((relevant_et>>clos(star(app(Msg, [1, 4]))));1)).
