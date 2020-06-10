:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, list_et) :- deep_subdict(_event, _{event:"func_pre", name:"add"}).
match(_event, list_et) :- deep_subdict(_event, _{event:"func_pre", name:"remove"}).
match(_event, hasNext_et(Id, Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[Id]}).
match(_event, next_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[Id]}).
match(_event, newIter_et(Id)) :- deep_subdict(_event, _{event:"func_post", name:"iterator", res:Id, args:[]}).
match(_event, freeIter_et(Id)) :- deep_subdict(_event, _{event:"func_post", name:"free", res:Id}).
match(_event, hasNext_or_next_et(Id)) :- match(_event, hasNext_et(Id, _)).
match(_event, hasNext_or_next_et(Id)) :- match(_event, next_et(Id)).
match(_event, iterator_et) :- match(_event, newIter_et(_)).
match(_event, iterator_et) :- match(_event, hasNext_or_next_et(_)).
match(_event, iterator_et) :- match(_event, freeIter_et(_)).
match(_event, not_newIter_et) :- not(match(_event, newIter_et(_))).
match(_event, list_or_iter_et(Id)) :- match(_event, hasNext_or_next_et(Id)).
match(_event, list_or_iter_et(Id)) :- match(_event, freeIter_et(Id)).
match(_event, list_or_iter_et(Id)) :- match(_event, list_et).
match(_event, relevant_et) :- match(_event, iterator_et).
match(_event, relevant_et) :- match(_event, list_et).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>ListIterators);1)),
	(ListIterators=(ListSafe/\((iterator_et>>Iterators);1))),
	(ListSafe=(star(not_newIter_et)*optional(var(id, (newIter_et(var(id))*(app(ListSafeIter, [var(id)])/\ListSafe)))))),
	(ListSafeIter=gen([id], ((list_or_iter_et(var(id))>>(star(hasNext_or_next_et(var(id)))*(star(list_et)*(freeIter_et(var(id))*1))));1))),
	(Iterators=optional(var(id, (newIter_et(var(id))*((app(Iterator, [var(id)])*freeIter_et(var(id)))|Iterators))))),
	(Iterator=gen([id], clos((star((plus(hasNext_et(var(id), true))*next_et(var(id))))*plus(hasNext_et(var(id), false)))))).
