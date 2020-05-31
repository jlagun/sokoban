/***************************************************************************/
/* Depth-first search solving framework                                    */
/***************************************************************************/
/* Depth-first search (DFS) is an algorithm for traversing or searching    */
/* tree or graph data structures. This algorithm can be applied to         */
/* combinatorial problems and guarantees to find the optimal solution      */
/* as it traverses the entire graph. Nevertheless for large graphs time    */
/* and/or resources may be a limitation.                                   */
/*                                                                         */
/***************************************************************************/

/* The problem is solved if the state is equal to final_state.             */
solve_dfs(Problem, State, _History, [], Acc, Acc) :-
    final_state(Problem, State).

/* If not, we have to explore new states                                   */
solve_dfs(Problem, State, History, [push(Box, Dir)|Moves], Acc, Result) :-
%    format('b4 movement~n'),
    movement(State, push(Box, Dir), SokobanMoves, PushPosition),
%    format('[.pl] SokobanMoves: ~w~n', SokobanMoves),
    update(State, push(Box, Dir), NewState),
%    format('b4 member~n'),
    \+ member(NewState, History),   /* No quiero ciclos en el grafo de búsqueda */
    append(SokobanMoves, [move(PushPosition, Dir)], AllM),
    append(Acc, AllM, NewSM),
    solve_dfs(Problem, NewState, [NewState|History], Moves, NewSM, Result).

/* Actually solve the problem                                              */
solve_problem(Problem, Solution, SokobanMoves) :-
    format('=============~n'),
    format('|| Problem: ~w~n', Problem),
    format('=============~n'),
    initial_state(Problem, Initial),
    format('Initial state: ~w~n', Initial),
    solve_dfs(Problem, Initial, [Initial], Solution, [], SokobanMoves).


/***************************************************************************/
/* Application to Sokoban: include game rules and board layout             */
/***************************************************************************/

/* Game rules                                                              */
:-include(game).

solve(Problem, Solution, SokobanMoves):-
/***************************************************************************/
/* Your code goes here                                                     */
/* You can use the code below as a hint.                                   */
/***************************************************************************/
    
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
