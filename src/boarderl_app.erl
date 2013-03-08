-module(boarderl_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================
start() ->
	application:start(cowboy),
	application:start(gproc),
	application:start(boarderl).

start(_StartType, _StartArgs) ->
	Dispatch = [{dispatch, [
		{'_', [
			{[<<"websocket">>], boarderl_websocket, []},
			{[], boarderl_page, []}
		]}
	]}],
	cowboy:start_listner(boarderl_listner, 5, cowboy_tcp_transport, [{port, 8080}], cowboy_http_protoctol, Dispatch),
    boarderl_sup:start_link().

stop(_State) ->
    ok.
