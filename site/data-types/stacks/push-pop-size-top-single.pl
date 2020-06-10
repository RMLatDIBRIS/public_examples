:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, push_et(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"mypush", args:[Val]}).
match(_event, pop_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"mypop", res:Val}).
match(_event, top_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"top", res:Val}).
match(_event, size_et(S)) :- deep_subdict(_event, _{event:"func_post", name:"size", res:S}).
match(_event, relevant_et) :- match(_event, push_et(_)).
match(_event, relevant_et) :- match(_event, pop_et(_)).
match(_event, relevant_et) :- match(_event, size_et(_)).
match(_event, relevant_et) :- match(_event, top_et(_)).
match(_event, push_et) :- match(_event, push_et(_)).
match(_event, pop_et) :- match(_event, pop_et(_)).
match(_event, not_size_et) :- not(match(_event, size_et(_))).
match(_event, not_top_et) :- not(match(_event, top_et(_))).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos((((not_size_et>>Stack);1)/\((not_top_et>>app(Size, [0]));1))));1)),
	(Stack=star(var(val, (push_et(var(val))*(star(top_et(var(val)))*(Stack*(star(top_et(var(val)))*pop_et(var(val))))))))),
	(Size=gen([s], optional((((size_et(var(s))*app(Size, [var(s)]))\/(pop_et*app(Size, [(var(s) - 1)])))\/(push_et*app(Size, [(var(s) + 1)])))))).
