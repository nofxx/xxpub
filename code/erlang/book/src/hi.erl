-module(hi).

-export([hi/1, hihi/0, fi/1, print_each/1, comp_test/0]).

hi(Name) ->
  io:fwrite("hii ~s\n", [Name]).

hihi() ->
    erlang:display("Oi"),
    io:format("vc..~n").

fi(Str) ->
  io:fwrite(" => ~s <= ",[Str]).

print_each([]) -> ok;
print_each([Ary|T]) ->
    io:format("\nX-> ~p", [Ary]),
    print_each(T).


comp_test() ->
    Ary = [1,2,3,4,5],
    R = [10 * X || X <- Ary], %% Do with X |WHERE| X from Ary
    print_each(R).

