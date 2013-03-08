-module(boarderl_page).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Any, http}, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
	{ok, Content} = file:read_file("../public/html/index.html"),
	{ok, Req2} = cowboy_http_req:reply(200, [], Content, Req),
	{ok, Req2, State}.

terminate(_Req, _State) ->
	ok.