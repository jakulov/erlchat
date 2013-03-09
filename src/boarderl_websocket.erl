-module(boarderl_websocket).
-export([init/3]).
-export([websocket_init/3, websocket_handle/3,
	websocket_info/3, websocket_terminate/3]).
	                               
init({tcp, http}, _Req, _Opt) ->
	{upgrade, protocol, cowboy_websocket}.

websocket_init(_Any, Req, _Opt) ->
	gproc:reg({p, l, main_room}),
	{ok, Req, undefined, hibernate}.

websocket_handle({text, Data}, Req, State) ->
	gproc:send({p, l, main_room}, Data),
	{ok, Req, State};

websocket_handle(_Any, Req, State) ->
	{ok, Req, State}.

websocket_info(_Info, Req, State) ->
	io:format("~p~n",[_Info]),
	{reply, {text, _Info}, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
	ok.