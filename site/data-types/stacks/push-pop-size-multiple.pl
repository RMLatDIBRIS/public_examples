:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, new(Id)) :- deep_subdict(_event, _{event:"func_post", name:"mynew", res:Id}).
match(_event, free(Id)) :- deep_subdict(_event, _{event:"func_pre", name:"myfree", args:[Id]}).
match(_event, push(Id, Val)) :- deep_subdict(_event, _{event:"func_pre", name:"mypush", args:[Id, Val]}).
match(_event, pop(Id, Val)) :- deep_subdict(_event, _{event:"func_post", name:"mypop", args:[Id], res:Val}).
match(_event, size(Id, S)) :- deep_subdict(_event, _{event:"func_post", name:"mysize", args:[Id], res:S}).
match(_event, relevant) :- match(_event, new(_)).
match(_event, relevant) :- match(_event, free(_)).
match(_event, relevant) :- match(_event, push(_, _)).
match(_event, relevant) :- match(_event, pop(_, _)).
match(_event, relevant) :- match(_event, size(_, _)).
match(_event, push) :- match(_event, push(_, _)).
match(_event, pop) :- match(_event, pop(_, _)).
match(_event, not_size) :- not(match(_event, size(_, _))).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>Stacks);1)),
	(Stacks=optional(var(id, (new(var(id))*(Stacks|(app(Single, [var(id)])*free(var(id)))))))),
	(Single=gen([id], clos((((not_size>>app(Stack, [var(id)]));1)/\app(Size, [var(id), 0]))))),
	(Stack=gen([id], star(var(val, (push(var(id), var(val))*(app(Stack, [var(id)])*pop(var(id), var(val)))))))),
	(Size=gen([id, s], optional((((size(var(id), var(s))*app(Size, [var(id), var(s)]))\/(pop*app(Size, [var(id), (var(s) - 1)])))\/(push*app(Size, [var(id), (var(s) + 1)])))))).
