:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, msg_et(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"msg", args:[Ty]}).
match(_event, ack_et(Ty)) :- deep_subdict(_event, _{event:"func_pre", name:"ack", args:[Ty]}).
match(_event, no_msg_et) :- not(match(_event, msg_et(_))).
match(_event, relevant_et) :- match(_event, msg_et(_)).
match(_event, relevant_et) :- match(_event, ack_et(_)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>(Prop1_2/\Prop3));1)),
	(Prop1_2=(star((msg_et(1)*ack_et(1)))|star((msg_et(2)*ack_et(2))))),
	(Prop3=star((msg_et(1)*(star(no_msg_et)*(msg_et(2)*star(no_msg_et)))))).
