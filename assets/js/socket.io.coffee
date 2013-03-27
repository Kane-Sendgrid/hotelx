socket = io.connect "http://localhost:3000"

socket.emit "chat",
	"ping from client!"

socket.on "chat-reply", (data) ->
	console.log "reply from server: " + data