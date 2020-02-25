:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, acquire(El)) :- deep_subdict(_{event:"func_post", name:"myadd", args:[El], res:true}, _event).
match(_event, use(El)) :- deep_subdict(_{event:"func_post", name:"myadd", args:[El], res:false}, _event).
match(_event, release(El)) :- deep_subdict(_{event:"func_post", name:"mydelete", args:[El], res:true}, _event).
match(_event, no_use(El)) :- deep_subdict(_{event:"func_post", name:"mydelete", args:[El], res:false}, _event).
match(_event, no_use) :- match(_event, no_use(_)).
match(_event, acqRelNoUse(El)) :- match(_event, acquire(El)).
match(_event, acqRelNoUse(El)) :- match(_event, release(El)).
match(_event, acqRelNoUse(El)) :- match(_event, no_use(El)).
match(_event, relevant) :- match(_event, acqRelNoUse(_)).
match(_event, relevant) :- match(_event, use(_)).
match(_event, any) :- deep_subdict(_{}, _event).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>clos(Set));1)),
	(Set=optional((star((no_use:eps))*var(el, ((acquire(var(el)):eps)*((Set|(star((use(var(el)):eps))*(release(var(el)):eps)))/\((acqRelNoUse(var(el))>>((release(var(el)):eps)*1));1))))))).
