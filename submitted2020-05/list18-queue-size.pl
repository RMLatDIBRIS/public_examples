:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq(Val)) :- deep_subdict(_{event:"func_pre", name:"enqueue", args:[Val]}, _event).
match(_event, deq(Val)) :- deep_subdict(_{event:"func_post", name:"dequeue", res:Val}, _event).
match(_event, size(S)) :- deep_subdict(_{event:"func_post", name:"size", res:S}, _event).
match(_event, enq) :- match(_event, enq(_)).
match(_event, deq) :- match(_event, deq(_)).
match(_event, enqDeq) :- match(_event, enq).
match(_event, enqDeq) :- match(_event, deq).
match(_event, relevant) :- match(_event, enq).
match(_event, relevant) :- match(_event, deq).
match(_event, relevant) :- match(_event, size(_)).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Queue=optional(var(val, ((enq(var(val)):eps)*(((deq:eps)|Queue)/\((deq>>((deq(var(val)):eps)*1));1)))))),
	(Size=gen([s], optional(((((size(var(s)):eps)*app(Size, [var(s)]))\/((enq:eps)*app(Size, [(var(s) + 1)])))\/((deq:eps)*app(Size, [(var(s) - 1)])))))),
	(Main=((relevant>>(((enqDeq>>Queue);1)/\app(Size, [0])));1)).
