:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, hasNext(Id, Res)) :- deep_subdict(_event, _{event:"func_post", name:"hasNext", res:Res, args:[Id]}).
match(_event, next(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"next", args:[Id]}).
match(_event, newIter(Id)) :- deep_subdict(_event, _{event:"func_post", name:"iterator", res:Id, args:[]}).
match(_event, relevant) :- match(_event, hasNext(_, _)).
match(_event, relevant) :- match(_event, next(_)).
match(_event, relevant) :- match(_event, newIter(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Iterators);1)),
	(Iterators=optional(var(id, (newIter(var(id))*(app(Iterator, [var(id)])|Iterators))))),
	(Iterator=gen([id], (star((hasNext(var(id), true)*next(var(id))))*hasNext(var(id), false)))).
