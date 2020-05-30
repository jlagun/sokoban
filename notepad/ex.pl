initial_state([_, _, [], _, sokoban(Sokoban)], state(Sokoban, [])).
initial_state([_, _, [box(XY)|L], _, sokoban(Sokoban)], state(Sokoban, [XY|R])) :-
    initial_state([_, _, L, _, sokoban(Sokoban)], state(Sokoban, R)).
