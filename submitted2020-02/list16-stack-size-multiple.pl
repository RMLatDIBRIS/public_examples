:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, new(Id)) :- deep_subdict(_{event:"func_post", name:"mynew", res:Id}, _event).
match(_event, free(Id)) :- deep_subdict(_{event:"func_pre", name:"myfree", args:[Id]}, _event).
match(_event, push(Id, Val)) :- deep_subdict(_{event:"func_pre", name:"mypush", args:[Id, Val]}, _event).
match(_event, pop(Id, Val)) :- deep_subdict(_{event:"func_post", name:"mypop", args:[Id], res:Val}, _event).
match(_event, size(Id, S)) :- deep_subdict(_{event:"func_post", name:"mysize", args:[Id], res:S}, _event).
match(_event, relevant) :- match(_event, new(_)).
match(_event, relevant) :- match(_event, free(_)).
match(_event, relevant) :- match(_event, push(_, _)).
match(_event, relevant) :- match(_event, pop(_, _)).
match(_event, relevant) :- match(_event, size(_, _)).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Stack=gen([id, s], (((size(var(id), var(s)):eps)*app(Stack, [var(id), var(s)]))\/optional(var(val, ((push(var(id), var(val)):eps)*(app(Stack, [var(id), (var(s) + 1)])*((pop(var(id), var(val)):eps)*app(Stack, [var(id), var(s)]))))))))),
	(Stacks=optional(var(id, ((new(var(id)):eps)*(Stacks|(app(Stack, [var(id), 0])*(free(var(id)):eps))))))),
	(Main=((relevant>>Stacks);1)).
