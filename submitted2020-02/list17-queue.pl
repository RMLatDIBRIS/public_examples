:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq(Val)) :- deep_subdict(_{event:"func_pre", name:"enqueue", args:[Val]}, _event).
match(_event, deq(Val)) :- deep_subdict(_{event:"func_post", name:"dequeue", res:Val}, _event).
match(_event, deq) :- match(_event, deq(_)).
match(_event, relevant) :- match(_event, enq(_)).
match(_event, relevant) :- match(_event, deq).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Queue);1)),
	(Queue=optional(var(val, ((enq(var(val)):eps)*(((deq:eps)|Queue)/\((deq>>((deq(var(val)):eps)*1));1)))))).
