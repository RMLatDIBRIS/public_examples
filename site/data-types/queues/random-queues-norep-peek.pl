:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"enqueue", args:[Val]}).
match(_event, deq(Val)) :- deep_subdict(_event, _{event:"func_post", name:"dequeue", res:Val}).
match(_event, peek(Val)) :- deep_subdict(_event, _{event:"func_post", name:"peek", res:Val}).
match(_event, peek_deq) :- match(_event, peek(_)).
match(_event, peek_deq) :- match(_event, deq(_)).
match(_event, relevant) :- match(_event, enq(_)).
match(_event, relevant) :- match(_event, peek_deq).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>clos((Queue/\((peek_deq>>Seq);1))));1)),
	(Queue=var(val, (enq(var(val))*((star((enq(var(val))\/peek(var(val))))*deq(var(val)))|Queue)))),
	(Seq=star(var(val, (star(peek(var(val)))*deq(var(val)))))).
