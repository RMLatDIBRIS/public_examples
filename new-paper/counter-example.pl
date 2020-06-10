:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, one_et(V)) :- deep_subdict(_event, _{event:"func_pre", name:"foo", args:[V, _]}).
match(_event, two_et(V)) :- deep_subdict(_event, _{event:"func_pre", name:"foo", args:[_, V]}).
match(_event, relevant_et) :- match(_event, one_et(_)).
match(_event, relevant_et) :- match(_event, two_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>var(v, ((one_et(var(v))\/two_et(var(v)))/\two_et(var(v)))));1)).
