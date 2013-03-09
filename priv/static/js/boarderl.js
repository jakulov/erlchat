var wsHost = "ws://192.168.1.102:9090/websocket";
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
				document.title = document.title + ' - ' + pid;
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
		if($('#msg').val()) {
			sendMessage(ws);
		}
		return false;
	});

	$('#msg').focus();
	$('#send').click(function(){$('#msg').focus();});
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