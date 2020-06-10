:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, out_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"output", res:Val}).
match(_event, in_et(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"input", args:[Val]}).
match(_event, relevant_et) :- match(_event, out_et(_)).
match(_event, relevant_et) :- match(_event, in_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>var(val, (out_et(var(val))*in_et(var(val)))));1)).
