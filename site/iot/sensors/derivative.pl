:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, sensor_et(Val, Time)) :- deep_subdict(_event, _{event:"func_post", name:"sensor", res:_{value:Val, timestamp:Time}}).
match(_event, check_der_et(Val1, Time1, Val2, Time2)) :- match(_event, sensor_et(Val2, Time2)),
	{((abs(Delta) =< 1),(Delta =:= ((Val2 - Val1) / (Time2 - Time1))))}.
match(_event, relevant_et) :- match(_event, sensor_et(_, _)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(var(val1, var(time1, (sensor_et(var(val1), var(time1))*app(CheckDer, [var(val1), var(time1)]))))));1)),
	(CheckDer=gen([val1, time1], var(val2, var(time2, (check_der_et(var(val1), var(time1), var(val2), var(time2))*app(CheckDer, [var(val2), var(time2)])))))).
