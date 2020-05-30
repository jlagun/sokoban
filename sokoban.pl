initial_state([_, _, [], _, sokoban(Sokoban)], state(Sokoban, [])).
initial_state([_, _, [box(XY)|L], _, sokoban(Sokoban)], state(Sokoban, [XY|R])) :-
    initial_state([_, _, L, _, sokoban(Sokoban)], state(Sokoban, R)).

/* The problem is solved if the state is equal to final_state.             */
solve_dfs(Problem, State, _History, []) :-
    final_state(Problem, State).

/* If not, we have to explore new states                                   */
solve_dfs(Problem, State, History, [Move|Moves]) :-
    movement(State, Move),
    update(State, Move, NewState),
    \+ member(NewState, History),   /* No quiero ciclos en el grafo de búsqueda */
    solve_dfs(Problem, NewState, [NewState|History], Moves).

/* Actually solve the problem                                              */
solve_problem(Problem, Solution) :-
    format('=============~n'),
    format('|| Problem: ~w~n', Problem),
    format('=============~n'),
    initial_state(Problem, Initial),
    format('Initial state: ~w~n', Initial),
    solve_dfs(Problem, Initial, [Initial], Solution).

solve(Problem, Solution):-
/***************************************************************************/
/* Your code goes here                                                     */
/* You can use the code below as a hint.                                   */
/***************************************************************************/
    
%Problem = [Tops, Rights, Boxes, Solutions, sokoban(Sokoban)],
%abolish_all_tables,
%retractall(top(_,_)),
%findall(_, ( member(P, Tops), assert(P) ), _),
%retractall(right(_,_)),
%findall(_, ( member(P, Rights), assert(P) ), _),
%retractall(solution(_)),
%findall(_, ( member(P, Solutions), assert(P) ), _),
%
%retractall(initial_state(_,_)),
%findall(Box, member(box(Box), Boxes), BoxLocs),
%assert(initial_state(sokoban, state(Sokoban, BoxLocs))),
solve_problem(Problem, Solution).
