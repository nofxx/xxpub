-module(geo).
-export([area/1, euclidean_distance/2]).

%%-export([pow/2, sqrt/1])
%% pow(_,0) -> 1;
%% pow(N, M) -> N * pow(N, M-1).

%% sqrt(Q) -> pow(Q, 0.5).



area({sqr, S})    -> S * S;
area({ret, W, H}) -> W * H;
area({circ, R})   -> 3.14159 * R * R.

euclidean_distance(P1, P2) ->
    {X1, Y1} = P1,
    {X2, Y2} = P2,
    math:sqrt(math:pow(X2 - X1, 2) + math:pow(Y2 - Y1, 2)).

