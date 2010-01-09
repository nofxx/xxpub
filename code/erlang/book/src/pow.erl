-module(pow).
-export([pow/2]).

pow(N, M) ->
    Pids = pow_spawn(self(),M),
    %%Vals = lists:map(fun(P) -> P ! N end, Pids),
    lists:foldl(
      fun(_,Total) -> receive X -> X * Total end end,
      1 Vals).

pow_spawn(Pid, 0) ->
     [spawn(fun() -> receive _ -> Pid ! 1 end end )];
pow_spawn(Pid, M) ->
     [spawn(fun() -> receive X -> Pid ! X end end)
      | pow_spawn(Pid, M-1)].







