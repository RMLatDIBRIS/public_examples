:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, push(Val)) :- deep_subdict(_{event:"func_pre", name:"mypush", args:[Val]}, _event).
match(_event, pop(Val)) :- deep_subdict(_{event:"func_post", name:"mypop", res:Val}, _event).
match(_event, size(S)) :- deep_subdict(_{event:"func_post", name:"size", res:S}, _event).
match(_event, relevant) :- match(_event, push(_)).
match(_event, relevant) :- match(_event, pop(_)).
match(_event, relevant) :- match(_event, size(_)).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Stack=gen([s], (((size(var(s)):eps)*app(Stack, [var(s)]))\/optional(var(val, ((push(var(val)):eps)*(app(Stack, [(var(s) + 1)])*((pop(var(val)):eps)*app(Stack, [var(s)]))))))))),
	(Main=((relevant>>app(Stack, [0]));1)).
