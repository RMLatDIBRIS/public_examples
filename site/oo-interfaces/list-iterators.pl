:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, list) :- deep_subdict(_event, _{event:"func_pre", name:"add"}).
match(_event, list) :- deep_subdict(_event, _{event:"func_pre", name:"remove"}).
match(_event, hasNext(Id, Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[Id]}).
match(_event, next(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[Id]}).
match(_event, newIter(Id)) :- deep_subdict(_event, _{event:"func_post", name:"iterator", res:Id, args:[]}).
match(_event, freeIter(Id)) :- deep_subdict(_event, _{event:"func_post", name:"free", res:Id}).
match(_event, hasNext_or_next(Id)) :- match(_event, hasNext(Id, _)).
match(_event, hasNext_or_next(Id)) :- match(_event, next(Id)).
match(_event, iterator) :- match(_event, newIter(_)).
match(_event, iterator) :- match(_event, hasNext_or_next(_)).
match(_event, iterator) :- match(_event, freeIter(_)).
match(_event, not_newIter) :- not(match(_event, newIter(_))).
match(_event, list_or_iter(Id)) :- match(_event, hasNext_or_next(Id)).
match(_event, list_or_iter(Id)) :- match(_event, freeIter(Id)).
match(_event, list_or_iter(Id)) :- match(_event, list).
match(_event, relevant) :- match(_event, iterator).
match(_event, relevant) :- match(_event, list).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>ListIterators);1)),
	(ListIterators=(ListSafe/\((iterator>>Iterators);1))),
	(ListSafe=(star(not_newIter)*optional(var(id, (newIter(var(id))*(app(ListSafeIter, [var(id)])/\ListSafe)))))),
	(ListSafeIter=gen([id], ((list_or_iter(var(id))>>(star(hasNext_or_next(var(id)))*(star(list)*(freeIter(var(id))*1))));1))),
	(Iterators=optional(var(id, (newIter(var(id))*((app(Iterator, [var(id)])*freeIter(var(id)))|Iterators))))),
	(Iterator=gen([id], clos((star((plus(hasNext(var(id), true))*next(var(id))))*plus(hasNext(var(id), false)))))).
