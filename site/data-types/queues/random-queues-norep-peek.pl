:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq_et(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"enqueue", args:[Val]}).
match(_event, deq_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"dequeue", res:Val}).
match(_event, peek_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"peek", res:Val}).
match(_event, peek_deq_et) :- match(_event, peek_et(_)).
match(_event, peek_deq_et) :- match(_event, deq_et(_)).
match(_event, relevant_et) :- match(_event, enq_et(_)).
match(_event, relevant_et) :- match(_event, peek_deq_et).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos((Queue/\((peek_deq_et>>Seq);1))));1)),
	(Queue=var(val, (enq_et(var(val))*((star((enq_et(var(val))\/peek_et(var(val))))*deq_et(var(val)))|Queue)))),
	(Seq=star(var(val, (star(peek_et(var(val)))*deq_et(var(val)))))).
