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
trace_expression('Main', Main) :- (Main=((relevant_et>>(slash_et*(star_et*(star(slash_et)*(star((optional((not_star_slash_et*star(not_star_et)))*plus(star_et)))*slash_et)))));1)).
