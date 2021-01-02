:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, unsafe_et(Cont_id)) :- deep_subdict(_event, _{event:"func_pre", name:"add", args:[Cont_id|_]}).
match(_event, unsafe_et(Cont_id)) :- deep_subdict(_event, _{event:"func_pre", name:"remove", args:[Cont_id|_]}).
match(_event, hasNext_et(It_id, Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[It_id]}).
match(_event, next_et(It_id)) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[It_id]}).
match(_event, newIter_et(Cont_id, It_id)) :- deep_subdict(_event, _{event:"func_post", name:"iterator", res:It_id, args:[Cont_id]}).
match(_event, freeIter_et(It_id)) :- deep_subdict(_event, _{event:"func_post", name:"free", res:It_id}).
match(_event, newIter_et(It_id)) :- match(_event, newIter_et(_, It_id)).
match(_event, hasNext_or_next_et(It_id)) :- match(_event, hasNext_et(It_id, _)).
match(_event, hasNext_or_next_et(It_id)) :- match(_event, next_et(It_id)).
match(_event, iterator_et) :- match(_event, newIter_et(_)).
match(_event, iterator_et) :- match(_event, hasNext_or_next_et(_)).
match(_event, iterator_et) :- match(_event, freeIter_et(_)).
match(_event, not_newIter_et) :- not(match(_event, newIter_et(_))).
match(_event, unsafe_or_iter_et(Cont_id, It_id)) :- match(_event, hasNext_or_next_et(It_id)).
match(_event, unsafe_or_iter_et(Cont_id, It_id)) :- match(_event, freeIter_et(It_id)).
match(_event, unsafe_or_iter_et(Cont_id, It_id)) :- match(_event, unsafe_et(Cont_id)).
match(_event, relevant_et) :- match(_event, iterator_et).
match(_event, relevant_et) :- match(_event, unsafe_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>SafeIterators);1)),
	(SafeIterators=(Safe/\((iterator_et>>Iterators);1))),
	(Safe=(star(not_newIter_et)*optional(var(cont_id, var(it_id, (newIter_et(var(cont_id), var(it_id))*(app(SafeIter, [var(cont_id), var(it_id)])/\Safe))))))),
	(SafeIter=gen([cont_id, it_id], ((unsafe_or_iter_et(var(cont_id), var(it_id))>>(star(hasNext_or_next_et(var(it_id)))*(star(unsafe_et(var(cont_id)))*(freeIter_et(var(it_id))*1))));1))),
	(Iterators=optional(var(it_id, (newIter_et(var(it_id))*((app(Iterator, [var(it_id)])*freeIter_et(var(it_id)))|Iterators))))),
	(Iterator=gen([it_id], clos((star((plus(hasNext_et(var(it_id), true))*next_et(var(it_id))))*plus(hasNext_et(var(it_id), false)))))).
