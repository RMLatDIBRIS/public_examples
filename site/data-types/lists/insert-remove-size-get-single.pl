:- module(spec, [(trace_expression/2), (match/2)]).
:- use_module(monitor(deep_subdict)).
:- use_module(library(clpr)).
match(_event, insert_et(Index, Elem)) :- deep_subdict(_event, _{event:"func_pre", name:"my_insert", args:[Index, Elem]}).
match(_event, remove_et(Index, Elem)) :- deep_subdict(_event, _{event:"func_post", name:"my_remove", args:[Index], res:Elem}).
match(_event, size_et(Size)) :- deep_subdict(_event, _{event:"func_post", name:"my_size", args:[], res:Size}).
match(_event, get_et(Index, Elem)) :- deep_subdict(_event, _{event:"func_post", name:"my_get", args:[Index], res:Elem}).
match(_event, relevant_et) :- match(_event, insert_et(_, _)).
match(_event, relevant_et) :- match(_event, remove_et(_, _)).
match(_event, relevant_et) :- match(_event, size_et(_)).
match(_event, relevant_et) :- match(_event, get_et(_, _)).
match(_event, add_rm_get_et) :- match(_event, insert_et(_, _)).
match(_event, add_rm_get_et) :- match(_event, remove_et(_, _)).
match(_event, add_rm_get_et) :- match(_event, get_et(_, _)).
match(_event, insert_in_bounds_et(Size)) :- match(_event, insert_et(Index, _)),
	{((Index >= 0),(Index =< Size))}.
match(_event, remove_in_bounds_et(Size)) :- match(_event, remove_et(Index, _)),
	{((Index >= 0),(Index < Size))}.
match(_event, get_in_bounds_et(Size)) :- match(_event, get_et(Index, _)),
	{((Index >= 0),(Index < Size))}.
match(_event, get_size_et(Size)) :- match(_event, size_et(Size)).
match(_event, get_size_et(Size)) :- match(_event, get_in_bounds_et(Size)).
match(_event, not_insert_et) :- not(match(_event, insert_et(_, _))).
match(_event, increased_et(I)) :- match(_event, insert_et(Index, _)),
	{(Index =< I)}.
match(_event, decreased_et(I)) :- match(_event, remove_et(Index, _)),
	{(Index < I)}.
match(_event, irrelevant_modification_et(I)) :- match(_event, insert_et(Index, _)),
	{(Index > I)}.
match(_event, irrelevant_modification_et(I)) :- match(_event, remove_et(Index, _)),
	{(Index > I)}.
match(_event, irrelevant_get_et(I)) :- match(_event, get_et(Index, _)),
	{(Index =\= I)}.
match(_event, irrelevant_et(I)) :- match(_event, irrelevant_modification_et(I)).
match(_event, irrelevant_et(I)) :- match(_event, irrelevant_get_et(I)).
match(_event, any_et) :- deep_subdict(_event, _{}).
match(_event, none_et) :- not(match(_event, any_et)).
trace_expression('Main', Main) :- (Main=((relevant_et>>clos((app(CheckIndex, [0])/\((add_rm_get_et>>CheckElem);1))));1)),
	(CheckIndex=gen([size], (star(get_size_et(var(size)))*((insert_in_bounds_et(var(size))*app(CheckIndex, [(var(size) + 1)]))\/(remove_in_bounds_et(var(size))*app(CheckIndex, [(var(size) - 1)])))))),
	(CheckElem=(star(not_insert_et)*var(index, var(elem, (insert_et(var(index), var(elem))*(app(GetElem, [var(index), var(elem)])/\CheckElem)))))),
	(GetElem=gen([index, elem], (((((irrelevant_et(var(index))\/get_et(var(index), var(elem)))*app(GetElem, [var(index), var(elem)]))\/(increased_et(var(index))*app(GetElem, [(var(index) + 1), var(elem)])))\/(decreased_et(var(index))*app(GetElem, [(var(index) - 1), var(elem)])))\/(remove_et(var(index), var(elem))*1)))).
