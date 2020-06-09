:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, sensor(Time)) :- deep_subdict(_event, _{event:"func_post", name:"sensor", res:_{timestamp:Time}}).
match(_event, check_time(Time1, Time2)) :- match(_event, sensor(Time2)),
	{(Time2 > Time1)}.
match(_event, relevant) :- match(_event, sensor(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>clos(var(time, (sensor(var(time))*app(CheckTime, [var(time)])))));1)),
	(CheckTime=gen([time1], var(time2, (check_time(var(time1), var(time2))*app(CheckTime, [var(time2)]))))).
