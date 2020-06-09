:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, list(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"add", args:[Id|_]}).
match(_event, list(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"remove", args:[Id|_]}).
match(_event, hasNext(Id, Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[Id]}).
match(_event, next(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[Id]}).
match(_event, newIter(Lsid, Itid)) :- deep_subdict(_event, _{event:"func_post", name:"iterator", res:Itid, args:[Lsid]}).
match(_event, freeIter(Id)) :- deep_subdict(_event, _{event:"func_post", name:"free", res:Id}).
match(_event, newIter(Id)) :- match(_event, newIter(_, Id)).
match(_event, hasNext_or_next(Id)) :- match(_event, hasNext(Id, _)).
match(_event, hasNext_or_next(Id)) :- match(_event, next(Id)).
match(_event, iterator) :- match(_event, newIter(_)).
match(_event, iterator) :- match(_event, hasNext_or_next(_)).
match(_event, iterator) :- match(_event, freeIter(_)).
match(_event, not_newIter) :- not(match(_event, newIter(_))).
match(_event, list_or_iter(Lsid, Itid)) :- match(_event, hasNext_or_next(Itid)).
match(_event, list_or_iter(Lsid, Itid)) :- match(_event, freeIter(Itid)).
match(_event, list_or_iter(Lsid, Itid)) :- match(_event, list(Lsid)).
match(_event, relevant) :- match(_event, iterator).
match(_event, relevant) :- match(_event, list(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>ListIterators);1)),
	(ListIterators=(ListSafe/\((iterator>>Iterators);1))),
	(ListSafe=(star(not_newIter)*optional(var(lsid, var(itid, (newIter(var(lsid), var(itid))*(app(ListSafeIter, [var(lsid), var(itid)])/\ListSafe))))))),
	(ListSafeIter=gen([lsid, itid], ((list_or_iter(var(lsid), var(itid))>>(star(hasNext_or_next(var(itid)))*(star(list(var(lsid)))*(freeIter(var(itid))*1))));1))),
	(Iterators=optional(var(id, (newIter(var(id))*((app(Iterator, [var(id)])*freeIter(var(id)))|Iterators))))),
	(Iterator=gen([id], clos((star((plus(hasNext(var(id), true))*next(var(id))))*plus(hasNext(var(id), false)))))).
