:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, hasNext(Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[]}).
match(_event, next) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[]}).
match(_event, relevant) :- match(_event, hasNext(_)).
match(_event, relevant) :- match(_event, next).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Iterator);1)),
	(Iterator=(star((hasNext(true)*next))*hasNext(false))).
