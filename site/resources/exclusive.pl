:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire_et(Eid, Rid)) :- deep_subdict(_event, _{event:"func_pre", name:"acquire", args:[Eid, Rid|_]}).
match(_event, release_et(Eid, Rid)) :- deep_subdict(_event, _{event:"func_pre", name:"release", args:[Eid, Rid|_]}).
match(_event, use_et(Eid, Rid)) :- deep_subdict(_event, _{event:"func_pre", name:"use", args:[Eid, Rid|_]}).
match(_event, notAcqRel_et(Eid, Rid)) :- not(match(_event, acquire_et(_, Rid))),
	not(match(_event, release_et(Eid, Rid))).
match(_event, relevant_et) :- match(_event, acquire_et(_, _)).
match(_event, relevant_et) :- match(_event, release_et(_, _)).
match(_event, relevant_et) :- match(_event, use_et(_, _)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>Resources);1)),
	(Resources=optional(var(eid, var(rid, (acquire_et(var(eid), var(rid))*((Resources|(star(use_et(var(eid), var(rid)))*release_et(var(eid), var(rid))))/\(star(notAcqRel_et(var(eid), var(rid)))*(release_et(var(eid), var(rid))*1)))))))).
