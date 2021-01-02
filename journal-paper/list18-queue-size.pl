:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq_et(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"enqueue", args:[Val]}).
match(_event, deq_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"dequeue", res:Val}).
match(_event, size_et(S)) :- deep_subdict(_event, _{event:"func_post", name:"size", res:S}).
match(_event, enq_et) :- match(_event, enq_et(_)).
match(_event, deq_et) :- match(_event, deq_et(_)).
match(_event, enqDeq_et) :- match(_event, enq_et).
match(_event, enqDeq_et) :- match(_event, deq_et).
match(_event, relevant_et) :- match(_event, enq_et).
match(_event, relevant_et) :- match(_event, deq_et).
match(_event, relevant_et) :- match(_event, size_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Queue=optional(var(val, (enq_et(var(val))*((deq_et|Queue)/\((deq_et>>(deq_et(var(val))*1));1)))))),
	(Size=gen([s], optional((((size_et(var(s))*app(Size, [var(s)]))\/(enq_et*app(Size, [(var(s) + 1)])))\/(deq_et*app(Size, [(var(s) - 1)])))))),
	(Main=((relevant_et>>(((enqDeq_et>>Queue);1)/\app(Size, [0])));1)).
