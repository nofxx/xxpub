-module(client).

-compile(export_all).

register_nickname(Nickname) ->
  Pid = spawn(client, handle_messages, [Nickname]),
  router:register_nick(Nickname, Pid).

unregister_nickname(Nickname) -> router:unregister_nick(Nickname).

send_message(AddrP, Body) ->
  router:send_chat_message(AddrP, Body).

handle_messages(Nickname) ->
  receive
    {printmsg, Body} ->
      io:format("Crient ~p => ~p~n", [Nickname, Body]),
      handle_messages(Nickname);
      stop ->
        ok
      end.


start_router() ->
  router:start().
