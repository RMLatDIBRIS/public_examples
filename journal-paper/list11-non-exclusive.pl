:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"acquire", args:[_, Id|_]}).
match(_event, release_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"release", args:[_, Id|_]}).
match(_event, use_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"use", args:[_, Id|_]}).
match(_event, relevant_et) :- match(_event, acquire_et(_)).
match(_event, relevant_et) :- match(_event, release_et(_)).
match(_event, relevant_et) :- match(_event, use_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>Resources);1)),
	(Resources=optional(var(id, (acquire_et(var(id))*((star(use_et(var(id)))*release_et(var(id)))|Resources))))).
