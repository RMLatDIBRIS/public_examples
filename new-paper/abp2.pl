:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, msg(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"msg", args:[Ty]}).
match(_event, ack(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"ack", args:[Ty]}).
match(_event, no_msg) :- not(match(_event, msg(_))).
match(_event, relevant) :- match(_event, msg(_)).
match(_event, relevant) :- match(_event, ack(_)).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>(Prop1_2/\Prop3));1)),
	(Prop1_2=(star((msg(1)*ack(1)))|star((msg(2)*ack(2))))),
	(Prop3=(star((msg(1)*msg(2)))|star(no_msg))).
