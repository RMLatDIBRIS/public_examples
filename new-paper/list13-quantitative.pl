:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, available_et(Total)) :- deep_subdict(_event, _{event:"func_post", name:"available", res:Total}).
match(_event, use_et(Total, Used)) :- deep_subdict(_event, _{event:"func_pre", name:"use", args:[Used]}),
	{(Used =< Total)}.
match(_event, relevant_et) :- match(_event, available_et(_)).
match(_event, relevant_et) :- match(_event, use_et(_, _)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Use=gen([total], guarded((var(total) > 0), var(used, (use_et(var(total), var(used))*app(Use, [(var(total) - var(used))]))), eps))),
	(Main=((relevant_et>>var(total, clos((available_et(var(total))*app(Use, [var(total)])))));1)).
