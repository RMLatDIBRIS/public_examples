:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, available(Total)) :- deep_subdict(_{event:"func_post", name:"available", res:Total}, _event).
match(_event, use(Total, Used)) :- deep_subdict(_{event:"func_pre", name:"use", args:[Used]}, _event),
	{(Used =< Total)}.
match(_event, relevant) :- match(_event, available(_)).
match(_event, relevant) :- match(_event, use(_, _)).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Use=gen([total], guarded((var(total) > 0), var(used, ((use(var(total), var(used)):eps)*app(Use, [(var(total) - var(used))]))), eps))),
	(Main=((relevant>>var(total, clos(((available(var(total)):eps)*app(Use, [var(total)])))));1)).
