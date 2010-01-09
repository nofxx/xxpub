-module(shop).
-export([cost/1, total/1]).

cost(foo) -> 5;
cost(bar) -> 9.

%% shop:total([{foo,3}, {bar, 2}]).
total([{What, N}|T]) -> shop:cost(What) * N + total(T);
total([]) -> 0;
total(0) -> 0.
