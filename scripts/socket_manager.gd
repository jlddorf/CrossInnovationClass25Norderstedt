extends Node

@export var websocket_url : String = "localhost:8001" 
var socket: WebSocketPeer = WebSocketPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var error:= socket.connect_to_url(websocket_url)
	if error != OK:
		print("Got error %s when trying to establish socket connection, maybe check whether the server is online" % str(error))
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			print("Got data from server: ", socket.get_packet().get_string_from_utf8())
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code: int = socket.get_close_code()
		print("Web socket connection closed with code %d" % code)
		set_process(false)
