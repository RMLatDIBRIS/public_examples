:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, star) :- deep_subdict(_event, _{event:"func_pre", name:"star"}).
match(_event, slash) :- deep_subdict(_event, _{event:"func_pre", name:"slash"}).
match(_event, other) :- deep_subdict(_event, _{event:"func_pre", name:"other"}).
match(_event, not_star_slash) :- match(_event, other).
match(_event, not_star) :- match(_event, slash).
match(_event, not_star) :- match(_event, other).
match(_event, relevant) :- match(_event, star).
match(_event, relevant) :- match(_event, slash).
match(_event, relevant) :- match(_event, other).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>(slash*(star*Inner)));1)),
	(Inner=((not_star*Inner)\/(star*MayStop))),
	(MayStop=((slash\/(star*MayStop))\/(not_star_slash*Inner))).
