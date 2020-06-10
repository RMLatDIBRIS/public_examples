:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, sensor_et(Pos, Time)) :- deep_subdict(_event, _{event:"func_post", name:"sensor", res:_{position:Pos, time:Time}}).
match(_event, check_dots_et(Pos1, Time1, Pos2, Time2)) :- match(_event, sensor_et(Pos2, Time2)),
	{(((((((((((((((E =:= 2.718),(K =:= 5000)),(C =:= (18.6 * (10 ^ (-6))))),(M =:= 1)),(Phase =:= 0)),(Error =:= (10 ^ (-5)))),(Zeta =:= (C / (2 * ((M * K) ^ 0.5))))),(Omega0 =:= ((K / M) ^ 0.5))),(Omega1 =:= (Omega0 * ((1 - (Zeta ^ 2)) ^ 0.5)))),(Delta1 =:= (Pos1 - (Amplitude * ((E ^ (((-Zeta) * Omega0) * Time1)) * sin(((Omega1 * Time1) + Phase))))))),(Delta2 =:= (Pos2 - (Amplitude * ((E ^ (((-Zeta) * Omega0) * Time2)) * sin(((Omega1 * Time2) + Phase))))))),(Delta1 =< Error)),(Delta1 >= (-Error))),(Delta2 =< Error)),(Delta2 >= (-Error)))}.
match(_event, relevant_et) :- match(_event, sensor_et(_, _)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(var(pos1, var(time1, (sensor_et(var(pos1), var(time1))*app(CheckDot, [var(pos1), var(time1)]))))));1)),
	(CheckDot=gen([pos1, time1], var(pos2, var(time2, (check_dots_et(var(pos1), var(time1), var(pos2), var(time2))*app(CheckDot, [var(pos2), var(time2)])))))).
