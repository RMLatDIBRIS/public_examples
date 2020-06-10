:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, left_speed_et) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"left", speed:Val}]}),
	{(Val =< 10)}.
match(_event, right_speed_et) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"right", speed:Val}]}),
	{(Val =< 10)}.
match(_event, forward_speed_et) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"forward", speed:Val}]}),
	{(Val =< 15)}.
match(_event, backward_speed_et) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"backward", speed:Val}]}),
	{(Val =< 15)}.
match(_event, relevant_et) :- deep_subdict(_event, _{event:"func_pre", name:"command"}).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>star((((left_speed_et\/right_speed_et)\/forward_speed_et)\/backward_speed_et)));1)).
