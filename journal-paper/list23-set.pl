:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire_et(El)) :- deep_subdict(_event, _{event:"func_post", name:"myadd", args:[El], res:true}).
match(_event, use_et(El)) :- deep_subdict(_event, _{event:"func_post", name:"myadd", args:[El], res:false}).
match(_event, release_et(El)) :- deep_subdict(_event, _{event:"func_post", name:"mydelete", args:[El], res:true}).
match(_event, no_use_et(El)) :- deep_subdict(_event, _{event:"func_post", name:"mydelete", args:[El], res:false}).
match(_event, no_use_et) :- match(_event, no_use_et(_)).
match(_event, acqRelNoUse_et(El)) :- match(_event, acquire_et(El)).
match(_event, acqRelNoUse_et(El)) :- match(_event, release_et(El)).
match(_event, acqRelNoUse_et(El)) :- match(_event, no_use_et(El)).
match(_event, relevant_et) :- match(_event, acqRelNoUse_et(_)).
match(_event, relevant_et) :- match(_event, use_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(Set));1)),
	(Set=optional((star(no_use_et)*var(el, (acquire_et(var(el))*((Set|(star(use_et(var(el)))*release_et(var(el))))/\((acqRelNoUse_et(var(el))>>(release_et(var(el))*1));1))))))).
