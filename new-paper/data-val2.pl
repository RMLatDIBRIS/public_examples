:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, in(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"input", args:Val}).
match(_event, relevant) :- match(_event, in(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>var(val, (in(var(val))*in(var(val)))));1)).
