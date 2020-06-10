:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, sensor_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"sensor", res:_{value:Val}}).
match(_event, sensor_in_range_et(Low, High)) :- match(_event, sensor_et(Val)),
	{((Low =< Val),(Val =< High))}.
match(_event, relevant_et) :- match(_event, sensor_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>app(CheckRange, [22, 24]));1)),
	(CheckRange=gen([low, high], star(sensor_in_range_et(var(low), var(high))))).
