:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, enq_et(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"enqueue", args:[Val]}).
match(_event, deq_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"dequeue", res:Val}).
match(_event, deq_geq_et(Val)) :- match(_event, deq_et(Val2)),
	{(Val2 >= Val)}.
match(_event, enq_deq_geq_et(Val)) :- match(_event, enq_et(Val)).
match(_event, enq_deq_geq_et(Val)) :- match(_event, deq_geq_et(Val)).
match(_event, deq_et) :- match(_event, deq_et(_)).
match(_event, relevant_et) :- match(_event, deq_et).
match(_event, relevant_et) :- match(_event, enq_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos((Queue/\Sorted)));1)),
	(Queue=var(val, (enq_et(var(val))*(deq_et(var(val))|Queue)))),
	(Sorted=(var(val, (enq_et(var(val))*(((enq_deq_geq_et(var(val))>>(app(Cons, [var(val)])*1));1)/\Sorted)))\/(deq_et*Sorted))),
	(Cons=gen([val], (deq_et(var(val))\/(enq_et(var(val))*(deq_et(var(val))|app(Cons, [var(val)])))))).
