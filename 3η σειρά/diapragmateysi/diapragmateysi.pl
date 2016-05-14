diapragmateysi(List,Moves):-
	length(L,_),check(List,L),
	atomic_list_concat(L,Result),!,atom_codes(Result,Moves).

check([98,103,98,71,103,71,71,114,71,121,114,121],[]):-!.
check(List,[Move|Moves]):-
	round(List,Move,NextList),
	check(NextList, Moves).	

round([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11],1,[E2,E1,E5,E0,E4,E3,E6,E7,E8,E9,E10,E11]).
round([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11],2,[E0,E3,E2,E6,E1,E5,E4,E7,E8,E9,E10,E11]).
round([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11],3,[E0,E1,E2,E3,E4,E7,E6,E10,E5,E9,E8,E11]).
round([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11],4,[E0,E1,E2,E3,E4,E5,E8,E7,E11,E6,E10,E9]).