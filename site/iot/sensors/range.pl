:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, sensor(Val)) :- deep_subdict(_event, _{event:"func_post", name:"sensor", res:_{value:Val}}).
match(_event, sensor_in_range(Low, High)) :- match(_event, sensor(Val)),
	{((Low =< Val),(Val =< High))}.
match(_event, relevant) :- match(_event, sensor(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>app(CheckRange, [22, 24]));1)),
	(CheckRange=gen([low, high], star(sensor_in_range(var(low), var(high))))).
