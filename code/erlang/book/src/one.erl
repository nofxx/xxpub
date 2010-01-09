-module(one).

-export([say_hi/0, mult/2, fac/1, even/1, perms/1, convert/2, convert_length/1, format_temps/1]).

% Tup  = {rio, {c, 40}}.
% Tups = [{rio, {c, 40}}, 2, 3].
% [One, Two |TheRest] = [1,2,3,4].   One=> 1, .. TheRest => [3,4]

say_hi() -> io:format("hello~n", []).

mult(X, Y) -> X * Y.

even(X) -> (X rem 2) =:= 0.

fac(1) -> 1;
fac(N) -> N * fac(N - 1).

%% factorial(0) -> 1;
%% factorial(N) when N > 0 -> N * factorial(N - 1).

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

%% Convert
convert(N, inch) -> N / 2.54;
convert(M, cent) -> M * 2.54.

convert_length({cent, X}) -> {inch, X / 2.54};
convert_length({inch, Y}) -> {cent, Y * 2.54}.

% test
%% Example from getting started
%% Only this function is exported
format_temps([])->                        % No output for an empty list
    ok;
format_temps([City | Rest]) ->
    print_temp(convert_to_celsius(City)),
    format_temps(Rest).


convert_to_celsius({Name, {c, Temp}}) ->  % No conversion needed
    {Name, {c, Temp}};
convert_to_celsius({Name, {f, Temp}}) ->  % Do the conversion
    {Name, {c, (Temp - 32) * 5 / 9}}.

print_temp({Name, {c, Temp}}) ->
    io:format("~-15w ~w c~n", [Name, Temp]).

