:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, a_et) :- deep_subdict(_event, _{event:"func_pre", name:"a"}).
match(_event, b_et) :- deep_subdict(_event, _{event:"func_pre", name:"b"}).
match(_event, relevant_et) :- match(_event, a_et).
match(_event, relevant_et) :- match(_event, b_et).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>plus(plus(a_et)));1)).
