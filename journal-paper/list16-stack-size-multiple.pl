:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, new_et(Id)) :- deep_subdict(_event, _{event:"func_post", name:"mynew", res:Id}).
match(_event, free_et(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"myfree", args:[Id]}).
match(_event, push_et(Id, Val)) :- deep_subdict(_event, _{event:"func_pre", name:"mypush", args:[Id, Val]}).
match(_event, pop_et(Id, Val)) :- deep_subdict(_event, _{event:"func_post", name:"mypop", args:[Id], res:Val}).
match(_event, size_et(Id, S)) :- deep_subdict(_event, _{event:"func_post", name:"mysize", args:[Id], res:S}).
match(_event, relevant_et) :- match(_event, new_et(_)).
match(_event, relevant_et) :- match(_event, free_et(_)).
match(_event, relevant_et) :- match(_event, push_et(_, _)).
match(_event, relevant_et) :- match(_event, pop_et(_, _)).
match(_event, relevant_et) :- match(_event, size_et(_, _)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Stack=gen([id, s], ((size_et(var(id), var(s))*app(Stack, [var(id), var(s)]))\/optional(var(val, (push_et(var(id), var(val))*(app(Stack, [var(id), (var(s) + 1)])*(pop_et(var(id), var(val))*app(Stack, [var(id), var(s)]))))))))),
	(Stacks=optional(var(id, (new_et(var(id))*(Stacks|(app(Stack, [var(id), 0])*free_et(var(id)))))))),
	(Main=((relevant_et>>Stacks);1)).
