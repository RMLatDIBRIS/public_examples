:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, one(V)) :- deep_subdict(_event, _{event:"func_pre", name:"foo", args:[V, _]}).
match(_event, two(V)) :- deep_subdict(_event, _{event:"func_pre", name:"foo", args:[_, V]}).
match(_event, relevant) :- match(_event, one(_)).
match(_event, relevant) :- match(_event, two(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>var(v, ((one(var(v))\/two(var(v)))/\two(var(v)))));1)).
