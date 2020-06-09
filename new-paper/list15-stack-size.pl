:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, push(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"mypush", args:[Val]}).
match(_event, pop(Val)) :- deep_subdict(_event, _{event:"func_post", name:"mypop", res:Val}).
match(_event, size(S)) :- deep_subdict(_event, _{event:"func_post", name:"size", res:S}).
match(_event, relevant) :- match(_event, push(_)).
match(_event, relevant) :- match(_event, pop(_)).
match(_event, relevant) :- match(_event, size(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Stack=gen([s], ((size(var(s))*app(Stack, [var(s)]))\/optional(var(val, (push(var(val))*(app(Stack, [(var(s) + 1)])*(pop(var(val))*app(Stack, [var(s)]))))))))),
	(Main=((relevant>>app(Stack, [0]));1)).
