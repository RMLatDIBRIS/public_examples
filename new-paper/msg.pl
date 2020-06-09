:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, msg(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"msg", args:[Ty]}).
match(_event, relevant) :- match(_event, msg(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Msg=gen([inf, sup], guarded((var(inf) =< var(sup)), (msg(var(inf))*app(Msg, [(var(inf) + 1), var(sup)])), eps))),
	(Main=((relevant>>clos(star(app(Msg, [1, 4]))));1)).
