-module(router).

-define(SERVER, router).

-compile(export_all).

start() ->
  global:trans({?SERVER, ?SERVER},
  fun() ->
    case global:whereis_name(?SERVER) of
      undefined ->
        Pid = spawn(router, route, [dict:new()]),
        global:register_name(?SERVER, Pid);
        _ ->
          ok
        end
      end).


      stop() ->
        global:trans({?SERVER, ?SERVER},
        fun() ->
          case global:whereis_name(?SERVER) of
            undefined ->
              ok;
              _ ->
                global:send(?SERVER, shutdown)
              end
            end).


send_chat_message(Addr, Body) ->
    global:send(?SERVER, {send_chat_msg, Addr, Body}).

register_nick(ClientName, ClientPid) ->
    global:send(?SERVER, {register_nick, ClientName, ClientPid}).

unregister_nick(ClientName) ->
    global:send(?SERVER, {unregister_nick, ClientName}).

has_nick(ClientName) ->
    global:send(?SERVER, {has_nick, ClientName}).

route(Clients) ->
  receive
      {send_chat_msg, ClientName, Body} ->
          case dict:find(ClientName, Clients) of
              {ok, ClientPid} ->
                  ClientPid ! {printmsg, Body};
              error ->
                  io:format("Err... ~p~n", [ClientName])
          end,
          route(Clients);
      {has_nick, ClientName} ->
          case dict:find(ClientName, Clients) of
              ok ->
                  io:format("Has!~n");
              error ->
                  io:format("Nobody...~n")
          end,
          route(Clients);
      {register_nick, ClientName, ClientPid} ->
          route(dict:store(ClientName, ClientPid, Clients));
      {unregister_nick, ClientName} ->
          case dict:find(ClientName, Clients) of
              {ok, ClientPid} ->
                  ClientPid ! stop,
                  route(dict:erase(ClientName, Clients));
              error ->
                  io:format("no client...."),
                  route(Clients)
              end;
      shutdown ->
          io:format("Shutting down...");
      Fail ->
          io:format("#Fail! ~p~n", [Fail]),
          route(Clients)
  end.
