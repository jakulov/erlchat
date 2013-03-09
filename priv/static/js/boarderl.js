var wsHost = "ws://localhost:9090/websocket";
$(document).ready(function() {
	
	var ws; // WebSocket Object
	var pid;
	
	if ("MozWebSocket" in window) {
		WebSocket = MozWebSocket;
	}
	
	if ("WebSocket" in window) {
		ws = new WebSocket(wsHost);
		ws.onopen = function() {
			addStatus("websocket connected!", "open");
			ws.send("joined chat!");
			addStatus("entering chat...", "send");
		};
		ws.onmessage = function (evt) {
			var receivedMsg = $.parseJSON(evt.data);
			if(!pid) {
				pid = receivedMsg.pid;
			}
			var context = (pid == receivedMsg.pid) ? "self" : "msg";
			addStatus('<b>' + receivedMsg.pid + ":</b> " + receivedMsg.text + "", context);
		};
		ws.onclose = function() {
			addStatus("websocket was closed", "close");
		};
	} 
	else {
		addStatus("sorry, your browser does not support websockets.", "error");
	}

	$('#chat').submit(function(){
		sendMessage(ws);
		return false;
	});

	$('#msg').focus();
});

function addStatus(text, context){
	var date = new Date();
	var msg = $('<p>').addClass(context).html(date.toLocaleTimeString() + ': ' + text);
	$("#status").append($(msg));
}

function sendMessage(ws) {
	ws.send($('#msg').val());
	$('#msg').val('');
}