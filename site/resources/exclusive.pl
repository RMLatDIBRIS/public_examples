:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire(Eid, Rid)) :- deep_subdict(_event, _{event:"func_pre", name:"acquire", args:[Eid, Rid|_]}).
match(_event, release(Eid, Rid)) :- deep_subdict(_event, _{event:"func_pre", name:"release", args:[Eid, Rid|_]}).
match(_event, use(Eid, Rid)) :- deep_subdict(_event, _{event:"func_pre", name:"use", args:[Eid, Rid|_]}).
match(_event, notAcqRel(Eid, Rid)) :- not(match(_event, acquire(_, Rid))),
	not(match(_event, release(Eid, Rid))).
match(_event, relevant) :- match(_event, acquire(_, _)).
match(_event, relevant) :- match(_event, release(_, _)).
match(_event, relevant) :- match(_event, use(_, _)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Resources);1)),
	(Resources=optional(var(eid, var(rid, (acquire(var(eid), var(rid))*((Resources|(star(use(var(eid), var(rid)))*release(var(eid), var(rid))))/\(star(notAcqRel(var(eid), var(rid)))*(release(var(eid), var(rid))*1)))))))).
