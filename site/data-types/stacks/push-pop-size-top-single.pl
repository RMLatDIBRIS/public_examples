:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, push(Val)) :- deep_subdict(_event, _{event:"func_pre", name:"mypush", args:[Val]}).
match(_event, pop(Val)) :- deep_subdict(_event, _{event:"func_post", name:"mypop", res:Val}).
match(_event, top(Val)) :- deep_subdict(_event, _{event:"func_post", name:"top", res:Val}).
match(_event, size(S)) :- deep_subdict(_event, _{event:"func_post", name:"size", res:S}).
match(_event, relevant) :- match(_event, push(_)).
match(_event, relevant) :- match(_event, pop(_)).
match(_event, relevant) :- match(_event, size(_)).
match(_event, relevant) :- match(_event, top(_)).
match(_event, push) :- match(_event, push(_)).
match(_event, pop) :- match(_event, pop(_)).
match(_event, not_size) :- not(match(_event, size(_))).
match(_event, not_top) :- not(match(_event, top(_))).
match(_event, any) :- deep_subdict(_event, _{}).
match(_event, none) :- not(match(_event, any)).
trace_expression('Main', Main) :- (Main=((relevant>>clos((((not_size>>Stack);1)/\((not_top>>app(Size, [0]));1))));1)),
	(Stack=star(var(val, (push(var(val))*(star(top(var(val)))*(Stack*(star(top(var(val)))*pop(var(val))))))))),
	(Size=gen([s], optional((((size(var(s))*app(Size, [var(s)]))\/(pop*app(Size, [(var(s) - 1)])))\/(push*app(Size, [(var(s) + 1)])))))).
