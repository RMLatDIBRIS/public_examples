:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, left_speed) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"left", speed:Val}]}),
	{(Val =< 10)}.
match(_event, right_speed) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"right", speed:Val}]}),
	{(Val =< 10)}.
match(_event, forward_speed) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"forward", speed:Val}]}),
	{(Val =< 15)}.
match(_event, backward_speed) :- deep_subdict(_event, _{event:"func_pre", name:"command", args:[_{topic:"wheels_control", direction:"backward", speed:Val}]}),
	{(Val =< 15)}.
match(_event, relevant) :- deep_subdict(_event, _{event:"func_pre", name:"command"}).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>star((((left_speed\/right_speed)\/forward_speed)\/backward_speed)));1)).
