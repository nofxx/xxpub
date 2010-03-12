-module(geo).

-export([area/1, radium/1, theta/1, bearing/2, euclidean_distance/2, spherical_distance/2]).

-define(Deg, 0.0174532925199433).
-define(degcos(X), math:cos(X * ?Deg)).

% Macro or Func ?
% -define(powsin(X,Y), math:pow(math:sin((X - Y) * ?Deg / 2), 2)).
powsin(X, Y) -> math:pow(math:sin((X - Y) * ?Deg / 2), 2).

area({sqr, S})    -> S * S;
area({ret, W, H}) -> W * H;
area({circ, R})   -> math:pi() * R * R.

euclidean_distance({X1, Y1}, {X2, Y2}) ->
    math:sqrt(math:pow(X2 - X1, 2) + math:pow(Y2 - Y1, 2)).

spherical_distance({X1, Y1}, {X2, Y2}) ->
    A = powsin(Y2, Y1) + ?degcos(Y1) * ?degcos(Y2) * powsin(X2, X1),
    2 * math:atan2(math:sqrt(A), math:sqrt(1-A)) * 6370997.0.

bearing({X1, Y1}, {X2, Y2}) ->
    {A, B} = {X2 - X1, Y2 - Y1},
    Res = math:acos(B / math:sqrt(A*A+B*B)) / math:pi() * 180,
    if A < 0 -> (360 - Res);
       true -> Res
    end.

radium({X, Y}) ->  math:sqrt(X*X+Y*Y).

theta({X, Y}) when X =:= 0 ->
    Res = math:pi() / 2,
    if Y < 0 -> (3 * Res);
       true -> Res
    end;
theta({X, Y}) ->
    Res = math:atan(Y/X),
    Rad = radium({X, Y}),
    if Rad > 0 -> Res;
       true -> Res * 2
    end.

