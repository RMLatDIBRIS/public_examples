:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, a) :- deep_subdict(_event, _{event:"func_pre", name:"a"}).
match(_event, b) :- deep_subdict(_event, _{event:"func_pre", name:"b"}).
match(_event, relevant) :- match(_event, a).
match(_event, relevant) :- match(_event, b).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>plus(plus(a)));1)).
