:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, add(El, Res)) :- deep_subdict(_event, _{event:"func_post", name:"myadd", args:[El], res:Res}).
match(_event, del(El, Res)) :- deep_subdict(_event, _{event:"func_post", name:"mydelete", args:[El], res:Res}).
match(_event, del_false) :- match(_event, del(_, false)).
match(_event, not_add_true_del(El)) :- not(match(_event, add(El, true))),
	not(match(_event, del(El, _))).
match(_event, relevant) :- match(_event, add(_, _)).
match(_event, relevant) :- match(_event, del(_, _)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>clos(Set));1)),
	(Set=(star(del_false)*optional(var(el, (add(var(el), true)*((Set|(star(add(var(el), false))*del(var(el), true)))/\(star(not_add_true_del(var(el)))*(del(var(el), true)*1)))))))).
