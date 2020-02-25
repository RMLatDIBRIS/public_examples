:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, push(Val)) :- deep_subdict(_{event:"func_pre", name:"mypush", args:[Val]}, _event).
match(_event, pop(Val)) :- deep_subdict(_{event:"func_post", name:"mypop", res:Val}, _event).
match(_event, relevant) :- match(_event, push(_)).
match(_event, relevant) :- match(_event, pop(_)).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Stack);1)),
	(Stack=star(var(val, ((push(var(val)):eps)*(Stack*(pop(var(val)):eps)))))).
