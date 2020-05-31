problem_solution(Problem, State, _History, [], Acc, Acc) :-
    final_state(Problem, State).

problem_solution(Problem, State, History, [push(Box, Dir)|Moves], Acc, Result) :-
    movement(State, push(Box, Dir), SokobanMoves, PushPosition),
    update(State, push(Box, Dir), NewState),
    \+ member(NewState, History),
    append(SokobanMoves, [move(PushPosition, Dir)], AllM),
    append(Acc, AllM, NewSM),
    problem_solution(Problem, NewState, [NewState|History], Moves, NewSM, Result).

solve_problem(Problem, Solution, SokobanMoves) :-
    format('=============~n'),
    format('|| Problem: ~w~n', Problem),
    format('=============~n'),
    initial_state(Problem, Initial),
    format('Initial state: ~w~n', Initial),
    problem_solution(Problem, Initial, [Initial], Solution, [], SokobanMoves).

/* Game rules                                                              */
:-include(game).

solve(Problem, Solution, SokobanMoves):-
    
Problem = [Tops, Rights, Boxes, Solutions, sokoban(Sokoban)],
abolish_all_tables,
retractall(top(_,_)),
findall(_, ( member(P, Tops), assert(P) ), _),
retractall(right(_,_)),
findall(_, ( member(P, Rights), assert(P) ), _),
retractall(solution(_)),
findall(_, ( member(P, Solutions), assert(P) ), _),

retractall(initial_state(_,_)),
findall(Box, member(box(Box), Boxes), BoxLocs),
assert(initial_state(sokoban, state(Sokoban, BoxLocs))),
solve_problem(sokoban, Solution, SokobanMoves).
