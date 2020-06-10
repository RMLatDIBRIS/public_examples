:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, push_et(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"mypush", args:[Val]}).
match(_event, pop_et(Val)) :- deep_subdict(_event, _{event:"func_post", name:"mypop", res:Val}).
match(_event, size_et(S)) :- deep_subdict(_event, _{event:"func_post", name:"size", res:S}).
match(_event, relevant_et) :- match(_event, push_et(_)).
match(_event, relevant_et) :- match(_event, pop_et(_)).
match(_event, relevant_et) :- match(_event, size_et(_)).
match(_event, push_et) :- match(_event, push_et(_)).
match(_event, pop_et) :- match(_event, pop_et(_)).
match(_event, not_size_et) :- not(match(_event, size_et(_))).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(app(Stack, [0])));1)),
	(Stack=gen([s], ((size_et(var(s))*app(Stack, [var(s)]))\/optional(var(val, (push_et(var(val))*(app(Stack, [(var(s) + 1)])*(pop_et(var(val))*app(Stack, [var(s)]))))))))).
