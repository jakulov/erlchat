-module(boarderl_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", boarderl_page, []},
			{"/websocket", boarderl_websocket, []},
			{"/static/[...]", cowboy_static, [
				{directory, {priv_dir, boarderl, [<<"static">>]}},
				{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
			]}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 9090}],
		[{env, [{dispatch, Dispatch}]}]),
	boarderl_sup:start_link().

stop(_State) ->
    ok.