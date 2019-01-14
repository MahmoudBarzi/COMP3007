%% Mahmoud Asadzadeh-Barzi
%% 100942882


transition(state([L,A,GI,GA],east,[],T),state([GI,GA],west,[L,A],Time)):-
                                                        Time is T-3.
transition(state([GI,GA],west,[L,A],T),state([L,GI,GA],east,[A],Time)):-
														Time is T-1.
transition(state([L,GI,GA],east,[A],T),state([GA],west,[L,A,GI],Time)):-
                                                        Time is T-5.
transition(state([GA],west,[L,A,GI],T),state([L,GA],east,[A,GI],Time)):-
                                                        Time is T-1.
transition(state([L,GA],east,[A,GI],T),state([],west,[L,A,GI,GA],Time)):-
                                                         Time is T-8.

isItPossible(T):-transition(state(_,_,_,0),state(_,_,_,T)),T>=0.
how(W,X,Y,Z,T):-transition(state(W,_,X,T),state(Y,_,Z,_)).





%% test:
%% isItPossible(15).
%% how(E,W,E1,W1,15).
%% keep pressing on ";" to see the results.