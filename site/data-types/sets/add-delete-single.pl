:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, add_et(El, Res)) :- deep_subdict(_event, _{event:"func_post", name:"myadd", args:[El], res:Res}).
match(_event, del_et(El, Res)) :- deep_subdict(_event, _{event:"func_post", name:"mydelete", args:[El], res:Res}).
match(_event, del_false_et) :- match(_event, del_et(_, false)).
match(_event, not_add_true_del_et(El)) :- not(match(_event, add_et(El, true))),
	not(match(_event, del_et(El, _))).
match(_event, relevant_et) :- match(_event, add_et(_, _)).
match(_event, relevant_et) :- match(_event, del_et(_, _)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos(Set));1)),
	(Set=(star(del_false_et)*optional(var(el, (add_et(var(el), true)*((Set|(star(add_et(var(el), false))*del_et(var(el), true)))/\(star(not_add_true_del_et(var(el)))*(del_et(var(el), true)*1)))))))).
