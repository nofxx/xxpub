-module(hi).

-export([hi/1, hihi/0, fi/1]).

hi(Name) ->
  io:fwrite("hii ~s\n", [Name]).

hihi() ->
    erlang:display("Oi"),
    io:format("vc..~n").
    
fi(Str) ->
  io:fwrite("=> ~s <=",[Str]).

