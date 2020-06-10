:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, star_et) :- deep_subdict(_event, _{event:"func_pre", name:"star"}).
match(_event, slash_et) :- deep_subdict(_event, _{event:"func_pre", name:"slash"}).
match(_event, other_et) :- deep_subdict(_event, _{event:"func_pre", name:"other"}).
match(_event, not_star_slash_et) :- match(_event, other_et).
match(_event, not_star_et) :- match(_event, slash_et).
match(_event, not_star_et) :- match(_event, other_et).
match(_event, relevant_et) :- match(_event, star_et).
match(_event, relevant_et) :- match(_event, slash_et).
match(_event, relevant_et) :- match(_event, other_et).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>(slash_et*(star_et*Inner)));1)),
	(Inner=((not_star_et*Inner)\/(star_et*MayStop))),
	(MayStop=((slash_et\/(star_et*MayStop))\/(not_star_slash_et*Inner))).
