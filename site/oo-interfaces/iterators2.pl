:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, hasNext_et(Id, Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[Id]}).
match(_event, next_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[Id]}).
match(_event, newIter_et(Id)) :- deep_subdict(_event, _{event:"func_post", name:"iterator", res:Id, args:[]}).
match(_event, freeIter_et(Id)) :- deep_subdict(_event, _{event:"func_post", name:"free", res:Id}).
match(_event, relevant_et) :- match(_event, hasNext_et(_, _)).
match(_event, relevant_et) :- match(_event, next_et(_)).
match(_event, relevant_et) :- match(_event, newIter_et(_)).
match(_event, relevant_et) :- match(_event, freeIter_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>Iterators);1)),
	(Iterators=optional(var(id, (newIter_et(var(id))*((app(Iterator, [var(id)])*freeIter_et(var(id)))|Iterators))))),
	(Iterator=gen([id], clos((star((plus(hasNext_et(var(id), true))*next_et(var(id))))*plus(hasNext_et(var(id), false)))))).
