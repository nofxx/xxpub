-module(one).

-export([say_hi/0, mult/2, even/1, perms/1, convert/2, convert_length/1, format_temps/1]).
-export([fac/1, tail_fac/1, len/1, tail_len/1, tail_reverse/1, tail_sublist/2]).

% Tup  = {rio, {c, 40}}.
% Tups = [{rio, {c, 40}}, 2, 3].
% [One, Two |TheRest] = [1,2,3,4].   One=> 1, .. TheRest => [3,4]

say_hi() -> io:format("hello~n", []).

mult(X, Y) -> X * Y.

even(X) -> (X rem 2) =:= 0.

%
% Recursion
%
perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

len([]) -> 0;
len([_|T]) -> 1 + len(T).

fac(1) -> 1;
fac(N) -> N * fac(N - 1).

%% factorial(0) -> 1;
%% factorial(N) when N > 0 -> N * factorial(N - 1).

% Tail recursion
tail_fac(N) -> tail_fac(N,1).

tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1,N*Acc).

tail_len(L) -> tail_len(L,0).

tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T,Acc+1).

tail_reverse(L) -> tail_reverse(L,[]).

tail_reverse([],Acc) -> Acc;
tail_reverse([H|T],Acc) -> tail_reverse(T, [H|Acc]).

tail_sublist(L, N) -> lists:reverse(tail_sublist(L, N, [])).

tail_sublist(_, 0, SubList) -> SubList;
tail_sublist([], _, SubList) -> SubList;
tail_sublist([H|T], N, SubList) ->
    tail_sublist(T, N-1, [H|SubList]).

%% Convert
convert(N, inch) -> N / 2.54;
convert(M, cent) -> M * 2.54.

convert_length({cent, X}) -> {inch, X / 2.54};
convert_length({inch, Y}) -> {cent, Y * 2.54}.

% test
%% Example from getting started
%% Only this function is exported
format_temps([]) -> ok;                       % No output for an empty list
format_temps([City | Rest]) ->
    print_temp(convert_to_celsius(City)),
    format_temps(Rest).


convert_to_celsius({Name, {c, Temp}}) ->  % No conversion needed
    {Name, {c, Temp}};
convert_to_celsius({Name, {f, Temp}}) ->  % Do the conversion
    {Name, {c, (Temp - 32) * 5 / 9}}.

print_temp({Name, {c, Temp}}) ->
    io:format("~-15w ~w c~n", [Name, Temp]).

