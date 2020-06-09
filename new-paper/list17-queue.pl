:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"enqueue", args:[Val]}).
match(_event, deq(Val)) :- deep_subdict(_event, _{event:"func_post", name:"dequeue", res:Val}).
match(_event, deq) :- match(_event, deq(_)).
match(_event, relevant) :- match(_event, enq(_)).
match(_event, relevant) :- match(_event, deq).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Queue);1)),
	(Queue=optional(var(val, (enq(var(val))*((deq|Queue)/\((deq>>(deq(var(val))*1));1)))))).