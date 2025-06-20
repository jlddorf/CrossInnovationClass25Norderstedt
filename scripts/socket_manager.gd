extends Node

@export var websocket_url : String
var socket: WebSocketPeer = WebSocketPeer.new()
@onready var json_parser: JSONParser = $JSON_parser

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting input client on url %s" % websocket_url)
	var error: Error = socket.connect_to_url(websocket_url)
	if error != OK:
		print("Got error %s when trying to establish socket connection, maybe check whether the server is online" % str(error))
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packetString: String = socket.get_packet().get_string_from_utf8()
			print("Got data from server: ", packetString)
			if JSON.parse_string(packetString) != null:
				var parsed : Dictionary = JSON.parse_string(packetString)
				json_parser.parse(parsed)
			
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code: int = socket.get_close_code()
		print("Web socket connection closed with code %d" % code)
		set_process(false)
