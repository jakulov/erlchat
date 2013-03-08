/*
	BoardErl js app
*/
$(document).ready(function() {
	console.log('DOM loaded');
	if ("MozWebSocket" in window) {
		WebSocket = MozWebSocket;
	}
	if ("WebSocket" in window) {
		// browser supports websockets
                ws = new WebSocket("ws://localhost:9090/websocket");
		ws.onopen = function() {
			// websocket is connected
			addStatus("websocket connected!");
			// send hello data to server.
			ws.send("hello server!");
			addStatus("sent message to server: 'hello server'!");
		};
		ws.onmessage = function (evt) {
			var receivedMsg = evt.data;
			addStatus("server sent the following: '" + receivedMsg + "'");
		};
		ws.onclose = function() {
			// websocket was closed
			addStatus("websocket was closed");
		};
	} else {
		// browser does not support websockets
		addStatus("sorry, your browser does not support websockets.");
	}
});