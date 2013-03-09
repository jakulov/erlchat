-module(boarderl).

-export([start/0, stop/1]).

start() ->
	ok = application:start(crypto),
	ok = application:start(ranch),
	ok = application:start(cowboy),
	ok = application:start(gproc),
	ok = application:start(boarderl).

stop(_State) ->
    ok.