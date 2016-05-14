lucky_numbers([H],L):-notlucky(H),L=[false],!.
lucky_numbers([H],L):-(\+notlucky(H)),L=[true],!.
lucky_numbers([H|T],L):-notlucky(H),lucky_numbers(T,L2),append([false],L2,L),!.
lucky_numbers([H|T],L):-(\+notlucky(H)),lucky_numbers(T,L2),append([true],L2,L),!.

notlucky(H):-
   number_codes(H,Temp),
   maplist(plus(48),Numbers,Temp),
   groups(Numbers,Combination),
   check(Combination),!.
   
groups([H1,H2],Result):-(X is H1*10+H2, Result = [X]);(Result = [H1,H2]).
groups([H1,H2|T],Result):-X is H1*10+H2,append([X],T,Temp),groups(Temp,Result).
groups([H1,H2|T],Result):-append([H2],T,Temp),groups(Temp,Result2),append([H1],Result2,Result).

check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E0+E1),check([X,E2,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E0-E1),check([X,E2,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E0*E1),check([X,E2,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E1=\=0),X is (E0/E1),check([X,E2,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E1+E2),check([E0,X,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E1-E2),check([E0,X,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E1*E2),check([E0,X,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E2=\=0),X is (E1/E2),check([E0,X,E3,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E2+E3),check([E0,E1,X,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E2-E3),check([E0,E1,X,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E2*E3),check([E0,E1,X,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E3=\=0),X is (E2/E3),check([E0,E1,X,E4,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E3+E4),check([E0,E1,E2,X,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E3-E4),check([E0,E1,E2,X,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E3*E4),check([E0,E1,E2,X,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E4=\=0),X is (E3/E4),check([E0,E1,E2,X,E5,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E4+E5),check([E0,E1,E2,E3,X,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E4-E5),check([E0,E1,E2,E3,X,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E4*E5),check([E0,E1,E2,E3,X,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E5=\=0),X is (E4/E5),check([E0,E1,E2,E3,X,E6,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E5+E6),check([E0,E1,E2,E3,E4,X,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E5-E6),check([E0,E1,E2,E3,E4,X,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E5*E6),check([E0,E1,E2,E3,E4,X,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E6=\=0),X is (E5/E6),check([E0,E1,E2,E3,E4,X,E7,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E6+E7),check([E0,E1,E2,E3,E4,E5,X,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E6-E7),check([E0,E1,E2,E3,E4,E5,X,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E6*E7),check([E0,E1,E2,E3,E4,E5,X,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E7=\=0),X is (E6/E7),check([E0,E1,E2,E3,E4,E5,X,E8,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E7+E8),check([E0,E1,E2,E3,E4,E5,E6,X,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E7-E8),check([E0,E1,E2,E3,E4,E5,E6,X,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E7*E8),check([E0,E1,E2,E3,E4,E5,E6,X,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E8=\=0),X is (E7/E8),check([E0,E1,E2,E3,E4,E5,E6,X,E9]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E8+E9),check([E0,E1,E2,E3,E4,E5,E6,E7,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E8-E9),check([E0,E1,E2,E3,E4,E5,E6,E7,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-X is (E8*E9),check([E0,E1,E2,E3,E4,E5,E6,E7,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8,E9]):-(E9=\=0),X is (E8/E9),check([E0,E1,E2,E3,E4,E5,E6,E7,X]).

check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E0+E1),check([X,E2,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E0-E1),check([X,E2,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E0*E1),check([X,E2,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E1=\=0),X is (E0/E1),check([X,E2,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E1+E2),check([E0,X,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E1-E2),check([E0,X,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E1*E2),check([E0,X,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E2=\=0),X is (E1/E2),check([E0,X,E3,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E2+E3),check([E0,E1,X,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E2-E3),check([E0,E1,X,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E2*E3),check([E0,E1,X,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E3=\=0),X is (E2/E3),check([E0,E1,X,E4,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E3+E4),check([E0,E1,E2,X,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E3-E4),check([E0,E1,E2,X,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E3*E4),check([E0,E1,E2,X,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E4=\=0),X is (E3/E4),check([E0,E1,E2,X,E5,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E4+E5),check([E0,E1,E2,E3,X,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E4-E5),check([E0,E1,E2,E3,X,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E4*E5),check([E0,E1,E2,E3,X,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E5=\=0),X is (E4/E5),check([E0,E1,E2,E3,X,E6,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E5+E6),check([E0,E1,E2,E3,E4,X,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E5-E6),check([E0,E1,E2,E3,E4,X,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E5*E6),check([E0,E1,E2,E3,E4,X,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E6=\=0),X is (E5/E6),check([E0,E1,E2,E3,E4,X,E7,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E6+E7),check([E0,E1,E2,E3,E4,E5,X,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E6-E7),check([E0,E1,E2,E3,E4,E5,X,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E6*E7),check([E0,E1,E2,E3,E4,E5,X,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E7=\=0),X is (E6/E7),check([E0,E1,E2,E3,E4,E5,X,E8]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E7+E8),check([E0,E1,E2,E3,E4,E5,E6,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E7-E8),check([E0,E1,E2,E3,E4,E5,E6,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-X is (E7*E8),check([E0,E1,E2,E3,E4,E5,E6,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7,E8]):-(E8=\=0),X is (E7/E8),check([E0,E1,E2,E3,E4,E5,E6,X]).

check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E0+E1),check([X,E2,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E0-E1),check([X,E2,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E0*E1),check([X,E2,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E1=\=0),X is (E0/E1),check([X,E2,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E1+E2),check([E0,X,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E1-E2),check([E0,X,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E1*E2),check([E0,X,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E2=\=0),X is (E1/E2),check([E0,X,E3,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E2+E3),check([E0,E1,X,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E2-E3),check([E0,E1,X,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E2*E3),check([E0,E1,X,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E3=\=0),X is (E2/E3),check([E0,E1,X,E4,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E3+E4),check([E0,E1,E2,X,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E3-E4),check([E0,E1,E2,X,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E3*E4),check([E0,E1,E2,X,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E4=\=0),X is (E3/E4),check([E0,E1,E2,X,E5,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E4+E5),check([E0,E1,E2,E3,X,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E4-E5),check([E0,E1,E2,E3,X,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E4*E5),check([E0,E1,E2,E3,X,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E5=\=0),X is (E4/E5),check([E0,E1,E2,E3,X,E6,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E5+E6),check([E0,E1,E2,E3,E4,X,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E5-E6),check([E0,E1,E2,E3,E4,X,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E5*E6),check([E0,E1,E2,E3,E4,X,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E6=\=0),X is (E5/E6),check([E0,E1,E2,E3,E4,X,E7]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E6+E7),check([E0,E1,E2,E3,E4,E5,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E6-E7),check([E0,E1,E2,E3,E4,E5,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-X is (E6*E7),check([E0,E1,E2,E3,E4,E5,X]).
check([E0,E1,E2,E3,E4,E5,E6,E7]):-(E7=\=0),X is (E6/E7),check([E0,E1,E2,E3,E4,E5,X]).

check([E0,E1,E2,E3,E4,E5,E6]):-X is (E0+E1),check([X,E2,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E0-E1),check([X,E2,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E0*E1),check([X,E2,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-(E1=\=0),X is (E0/E1),check([X,E2,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E1+E2),check([E0,X,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E1-E2),check([E0,X,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E1*E2),check([E0,X,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-(E2=\=0),X is (E1/E2),check([E0,X,E3,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E2+E3),check([E0,E1,X,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E2-E3),check([E0,E1,X,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E2*E3),check([E0,E1,X,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-(E3=\=0),X is (E2/E3),check([E0,E1,X,E4,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E3+E4),check([E0,E1,E2,X,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E3-E4),check([E0,E1,E2,X,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E3*E4),check([E0,E1,E2,X,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-(E4=\=0),X is (E3/E4),check([E0,E1,E2,X,E5,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E4+E5),check([E0,E1,E2,E3,X,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E4-E5),check([E0,E1,E2,E3,X,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E4*E5),check([E0,E1,E2,E3,X,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-(E5=\=0),X is (E4/E5),check([E0,E1,E2,E3,X,E6]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E5+E6),check([E0,E1,E2,E3,E4,X]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E5-E6),check([E0,E1,E2,E3,E4,X]).
check([E0,E1,E2,E3,E4,E5,E6]):-X is (E5*E6),check([E0,E1,E2,E3,E4,X]).
check([E0,E1,E2,E3,E4,E5,E6]):-(E6=\=0),X is (E5/E6),check([E0,E1,E2,E3,E4,X]).

check([E0,E1,E2,E3,E4,E5]):-X is (E0+E1),check([X,E2,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E0-E1),check([X,E2,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E0*E1),check([X,E2,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-(E1=\=0),X is (E0/E1),check([X,E2,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E1+E2),check([E0,X,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E1-E2),check([E0,X,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E1*E2),check([E0,X,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-(E2=\=0),X is (E1/E2),check([E0,X,E3,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E2+E3),check([E0,E1,X,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E2-E3),check([E0,E1,X,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E2*E3),check([E0,E1,X,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-(E3=\=0),X is (E2/E3),check([E0,E1,X,E4,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E3+E4),check([E0,E1,E2,X,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E3-E4),check([E0,E1,E2,X,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E3*E4),check([E0,E1,E2,X,E5]).
check([E0,E1,E2,E3,E4,E5]):-(E4=\=0),X is (E3/E4),check([E0,E1,E2,X,E5]).
check([E0,E1,E2,E3,E4,E5]):-X is (E4+E5),check([E0,E1,E2,E3,X]).
check([E0,E1,E2,E3,E4,E5]):-X is (E4-E5),check([E0,E1,E2,E3,X]).
check([E0,E1,E2,E3,E4,E5]):-X is (E4*E5),check([E0,E1,E2,E3,X]).
check([E0,E1,E2,E3,E4,E5]):-(E5=\=0),X is (E4/E5),check([E0,E1,E2,E3,X]).

check([E0,E1,E2,E3,E4]):-X is (E0+E1),check([X,E2,E3,E4]).
check([E0,E1,E2,E3,E4]):-X is (E0-E1),check([X,E2,E3,E4]).
check([E0,E1,E2,E3,E4]):-X is (E0*E1),check([X,E2,E3,E4]).
check([E0,E1,E2,E3,E4]):-(E1=\=0),X is (E0/E1),check([X,E2,E3,E4]).
check([E0,E1,E2,E3,E4]):-X is (E1+E2),check([E0,X,E3,E4]).
check([E0,E1,E2,E3,E4]):-X is (E1-E2),check([E0,X,E3,E4]).
check([E0,E1,E2,E3,E4]):-X is (E1*E2),check([E0,X,E3,E4]).
check([E0,E1,E2,E3,E4]):-(E2=\=0),X is (E1/E2),check([E0,X,E3,E4]).
check([E0,E1,E2,E3,E4]):-X is (E2+E3),check([E0,E1,X,E4]).
check([E0,E1,E2,E3,E4]):-X is (E2-E3),check([E0,E1,X,E4]).
check([E0,E1,E2,E3,E4]):-X is (E2*E3),check([E0,E1,X,E4]).
check([E0,E1,E2,E3,E4]):-(E3=\=0),X is (E2/E3),check([E0,E1,X,E4]).
check([E0,E1,E2,E3,E4]):-X is (E3+E4),check([E0,E1,E2,X]).
check([E0,E1,E2,E3,E4]):-X is (E3-E4),check([E0,E1,E2,X]).
check([E0,E1,E2,E3,E4]):-X is (E3*E4),check([E0,E1,E2,X]).
check([E0,E1,E2,E3,E4]):-(E4=\=0),X is (E3/E4),check([E0,E1,E2,X]).

check([E0,E1,E2,E3]):-X is (E0+E1),check([X,E2,E3]).
check([E0,E1,E2,E3]):-X is (E0-E1),check([X,E2,E3]).
check([E0,E1,E2,E3]):-X is (E0*E1),check([X,E2,E3]).
check([E0,E1,E2,E3]):-(E1=\=0),X is (E0/E1),check([X,E2,E3]).
check([E0,E1,E2,E3]):-X is (E1+E2),check([E0,X,E3]).
check([E0,E1,E2,E3]):-X is (E1-E2),check([E0,X,E3]).
check([E0,E1,E2,E3]):-X is (E1*E2),check([E0,X,E3]).
check([E0,E1,E2,E3]):-(E2=\=0),X is (E1/E2),check([E0,X,E3]).
check([E0,E1,E2,E3]):-X is (E2+E3),check([E0,E1,X]).
check([E0,E1,E2,E3]):-X is (E2-E3),check([E0,E1,X]).
check([E0,E1,E2,E3]):-X is (E2*E3),check([E0,E1,X]).
check([E0,E1,E2,E3]):-(E3=\=0),X is (E2/E3),check([E0,E1,X]).

check([E0,E1,E2]):-X is (E0+E1),check([X,E2]).
check([E0,E1,E2]):-X is (E0-E1),check([X,E2]).
check([E0,E1,E2]):-X is (E0*E1),check([X,E2]).
check([E0,E1,E2]):-(E1=\=0),X is (E0/E1),check([X,E2]).
check([E0,E1,E2]):-X is (E1+E2),check([E0,X]).
check([E0,E1,E2]):-X is (E1-E2),check([E0,X]).
check([E0,E1,E2]):-X is (E1*E2),check([E0,X]).
check([E0,E1,E2]):-(E2=\=0),X is (E1/E2),check([E0,X]).

check([E0,E1]):-X is (E0+E1),check([X]).
check([E0,E1]):-X is (E0-E1),check([X]).
check([E0,E1]):-X is (E0*E1),check([X]).
check([E0,E1]):-(E1=\=0),X is (E0/E1),check([X]).

check([E]):-(E==100).