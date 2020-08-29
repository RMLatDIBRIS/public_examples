:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, insert_et(Index, Val)) :- deep_subdict(_event, _{event:"func_pre", name:"my_insert", args:[Index, Val]}).
match(_event, remove_et(Index, Val)) :- deep_subdict(_event, _{event:"func_post", name:"my_remove", args:[Index], res:Val}).
match(_event, size_et(S)) :- deep_subdict(_event, _{event:"func_post", name:"my_size", args:[], res:S}).
match(_event, insert_sz_et(S)) :- match(_event, insert_et(Index, _)),
	{((Index >= 0),(Index =< S))}.
match(_event, remove_sz_et(S)) :- match(_event, remove_et(Index, _)),
	{((Index >= 0),(Index < S))}.
match(_event, relevant_et) :- match(_event, insert_et(_, _)).
match(_event, relevant_et) :- match(_event, remove_et(_, _)).
match(_event, relevant_et) :- match(_event, size_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>app(List, [0]));1)),
	(List=gen([s], (star(size_et(var(s)))*optional((insert_sz_et(var(s))*(app(List, [(var(s) + 1)])*(remove_sz_et((var(s) + 1))*app(List, [var(s)])))))))).
