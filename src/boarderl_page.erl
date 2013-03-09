-module(boarderl_page).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/3]).

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
	Html = get_html(),
	{ok, Req2} = cowboy_req:reply(
		200,
		[{<<"content-type">>, <<"text/html">>}],
		Html, 
		Req
	),
	{ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
	ok.

get_html() ->
	{ok, Cwd} = file:get_cwd(),
	Filename =filename:join([Cwd, "priv", "html", "index.html"]),
	{ok, Binary} = file:read_file(Filename),
	Binary.