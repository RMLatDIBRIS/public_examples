:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"acquire", args:[_, Id|_]}).
match(_event, release(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"release", args:[_, Id|_]}).
match(_event, use(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"use", args:[_, Id|_]}).
match(_event, acqRel(Id)) :- match(_event, acquire(Id)).
match(_event, acqRel(Id)) :- match(_event, release(Id)).
match(_event, relevant) :- match(_event, acquire(_)).
match(_event, relevant) :- match(_event, release(_)).
match(_event, relevant) :- match(_event, use(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Resources);1)),
	(Resources=optional(var(id, (acquire(var(id))*((Resources|(star(use(var(id)))*release(var(id))))/\((acqRel(var(id))>>(release(var(id))*1));1)))))).
