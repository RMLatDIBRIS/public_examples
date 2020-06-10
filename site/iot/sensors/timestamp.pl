:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, sensor_et(Time)) :- deep_subdict(_event, _{event:"func_post", name:"sensor", res:_{timestamp:Time}}).
match(_event, check_time_et(Time1, Time2)) :- match(_event, sensor_et(Time2)),
	{(Time2 > Time1)}.
match(_event, relevant_et) :- match(_event, sensor_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(var(time, (sensor_et(var(time))*app(CheckTime, [var(time)])))));1)),
	(CheckTime=gen([time1], var(time2, (check_time_et(var(time1), var(time2))*app(CheckTime, [var(time2)]))))).
