%% Mahmoud Asadzadeh-Barzi
%% 100942882

countInRange([],_,_,0).
countInRange([H|T],R1,R2,X):- 
						countInRange(T,R1,R2,X1),
						helpCountInRange(H,R1,R2),
						X is X1+1.

countInRange([H|T],R1,R2,X):- 
							\+(helpCountInRange(H,R1,R2)),
							countInRange(T,R1,R2,X).

helpCountInRange(E,R1,R2):- E>=R1,E=<R2.

