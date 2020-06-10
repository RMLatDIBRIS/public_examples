:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"acquire", args:[Id|_]}).
match(_event, release_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"release", args:[Id|_]}).
match(_event, use_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"use", args:[Id|_]}).
match(_event, relevant_et) :- match(_event, acquire_et(_)).
match(_event, relevant_et) :- match(_event, release_et(_)).
match(_event, relevant_et) :- match(_event, use_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>Resources);1)),
	(Resources=optional(var(rid, (acquire_et(var(rid))*(Resources|(star(use_et(var(rid)))*release_et(var(rid)))))))).
