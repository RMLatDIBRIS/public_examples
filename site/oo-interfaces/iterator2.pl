:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, hasNext_et(Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[]}).
match(_event, next_et) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[]}).
match(_event, relevant_et) :- match(_event, hasNext_et(_)).
match(_event, relevant_et) :- match(_event, next_et).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(Iterator));1)),
	(Iterator=(star((plus(hasNext_et(true))*next_et))*plus(hasNext_et(false)))).
